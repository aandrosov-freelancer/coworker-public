create table task_categories(
    id bigserial primary key,
    title text not null
);

alter table task_categories enable row level security;

create policy "everyone_can_view_categories" on task_categories for select using (true);