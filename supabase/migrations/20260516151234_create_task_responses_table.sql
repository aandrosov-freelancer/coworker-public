create table tasks_responses(
    id bigserial primary key,
    task_id bigserial references tasks(id) on delete cascade not null,
    performer_id uuid references profiles(id) on delete cascade not null,
    message text not null,
    matching_explanation text,
    coincidence real,
    created_at timestamp default current_timestamp
);

alter table tasks_responses enable row level security;

create policy "owner_can_see_responses" on tasks_responses for select using (exists (select customer_id from tasks where tasks.id = task_id and customer_id = auth.uid() LIMIT 1));
create policy "performer_can_see_own_responses" on tasks_responses for select using ((select auth.uid()) = performer_id);
create policy "performer_can_add_response" on tasks_responses for insert with check (exists (select id from profiles where id = auth.uid() and role = 'performer' LIMIT 1));