create table tasks (
    id bigserial primary key,
    customer_id uuid references profiles(id) on delete cascade not null,
    category_id bigserial references task_categories(id) on delete cascade not null,
    title text not null,
    description text not null,
    budget money not null,
    created_at timestamp default current_timestamp
);

alter table tasks enable row level security;

create policy "anyone_can_view_tasks" on tasks for select using (true);
create policy "owner_can_manage_own_task" on tasks for all using (auth.uid() = customer_id);