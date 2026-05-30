create table portfolios (
    id bigserial primary key,
    profile_id uuid not null references profiles,
    title varchar(511) not null,
    url varchar(512),
    description varchar(2047) not null,
    created_at timestamp default current_timestamp
);

alter table portfolios enable row level security;

create policy " anyone_can_view_portfolios" on portfolios
    for select;

create policy "owner_can_update_own_portfolio" on portfolios
    for update using ((select auth.uid()) = profile_id);

create policy "owner_can_delete_own_portfolio" on portfolios
    for delete using ((select auth.uid()) = profile_id);