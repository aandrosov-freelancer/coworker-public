import { createClient } from "@supabase/supabase-js"
import OpenAI from "openai"

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    const { task_id } = await req.json()

    if (!task_id) {
      throw new Error('task_id is required')
    }

    const { data: task, error: taskError } = await supabaseClient
      .from('tasks')
      .select('title, description')
      .eq('id', task_id)
      .single()

    if (taskError || !task) {
      throw new Error(`Task not found: ${taskError?.message}`)
    }

    const { data: responses, error: responsesError } = await supabaseClient
      .from('tasks_responses')
      .select(`
        id,
        message,
        performer:profiles (
          first_name,
          last_name,
          bio,
          focus
        )
      `)
      .eq('task_id', task_id)

    if (responsesError) {
      throw new Error(`Error fetching responses: ${responsesError.message}`)
    }

    if (!responses || responses.length === 0) {
      return new Response(
        JSON.stringify({ message: 'No candidates found for this task' }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    const promptTemplate = Deno.env.get('LLM_PROMPT') ?? ''
    
    const taskDescription = `Название: ${task.title}\Описание: ${task.description}`
    
    const candidatesText = responses.map((r: any) => {
      const p = r.performer
      return `ID: ${r.id}\nСообщение: ${r.message}\nОписание профиля: ${p.bio || 'N/A'}\nНаправление: ${p.focus || 'N/A'}`
    }).join('\n---\n')

    const fullPrompt = promptTemplate
      .replace('{вставь описание задачи}', taskDescription)
      .replace(/<candidates>[\s\S]*?<\/candidates>/, `<candidates>\n${candidatesText}\n</candidates>`)

    const openai = new OpenAI({
      apiKey: Deno.env.get('DEEPSEEK_API_KEY'),
      baseURL: 'https://api.deepseek.com',
    })

    const completion = await openai.chat.completions.create({
      messages: [{ role: "user", content: fullPrompt }],
      model: "deepseek-chat",
      response_format: { type: 'json_object' }
    })

    const resultText = completion.choices[0].message.content
    if (!resultText) {
      throw new Error('AI returned empty response')
    }

    let evaluatedCandidates: any[]
    try {
      const parsed = JSON.parse(resultText)
      evaluatedCandidates = Array.isArray(parsed) ? parsed : (parsed.candidates || [])
    } catch (e) {
      console.error('Failed to parse AI response:', resultText)
      throw new Error('Failed to parse AI evaluation result')
    }

    const updates = evaluatedCandidates.map(async (candidate: any) => {
      const { error: updateError } = await supabaseClient
        .from('tasks_responses')
        .update({
          coincidence: candidate.rating,
          matching_explanation: candidate.reason
        })
        .eq('id', candidate.id)
      
      if (updateError) {
        console.error(`Error updating response ${candidate.id}:`, updateError)
      }
    })

    await Promise.all(updates)

    return new Response(
      JSON.stringify({ 
        message: 'Candidates matched successfully', 
        count: evaluatedCandidates.length,
        results: evaluatedCandidates 
      }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )

  } catch (error: any) {
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }
})
