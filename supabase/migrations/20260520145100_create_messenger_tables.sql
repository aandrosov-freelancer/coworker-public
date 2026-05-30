CREATE TABLE public.chats (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user1_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    user2_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    UNIQUE(user1_id, user2_id)
);

CREATE TABLE public.messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    chat_id UUID REFERENCES public.chats(id) ON DELETE CASCADE NOT NULL,
    sender_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    text TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Turn on RLS
ALTER TABLE public.chats ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;

-- Policies for chats
CREATE POLICY "Users can view their own chats" ON public.chats
    FOR SELECT USING (auth.uid() = user1_id OR auth.uid() = user2_id);

CREATE POLICY "Users can insert chats they are part of" ON public.chats
    FOR INSERT WITH CHECK (auth.uid() = user1_id OR auth.uid() = user2_id);

CREATE POLICY "Users can update their own chats" ON public.chats
    FOR UPDATE USING (auth.uid() = user1_id OR auth.uid() = user2_id);

-- Policies for messages
CREATE POLICY "Users can view messages in their chats" ON public.messages
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM public.chats c
            WHERE c.id = messages.chat_id
            AND (c.user1_id = auth.uid() OR c.user2_id = auth.uid())
        )
    );

CREATE POLICY "Users can insert messages in their chats" ON public.messages
    FOR INSERT WITH CHECK (
        sender_id = auth.uid() AND
        EXISTS (
            SELECT 1 FROM public.chats c
            WHERE c.id = chat_id
            AND (c.user1_id = auth.uid() OR c.user2_id = auth.uid())
        )
    );

CREATE POLICY "Users can update messages in their chats (e.g. read status)" ON public.messages
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM public.chats c
            WHERE c.id = messages.chat_id
            AND (c.user1_id = auth.uid() OR c.user2_id = auth.uid())
        )
    );

-- Enable realtime for messages
alter publication supabase_realtime add table public.messages;
