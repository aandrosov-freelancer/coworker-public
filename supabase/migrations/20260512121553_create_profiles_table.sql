create type user_role as ENUM (
    'customer',
    'performer'
);

create table profiles (
	id uuid primary key references auth.users,
    first_name varchar(255) not null,
    last_name varchar(255) not null,
    email varchar (254) not null,
    image_url varchar(1024),
    focus varchar(255),
    bio text,
    location varchar(255),
    role user_role not null,
    created_at timestamp default current_timestamp
);

alter table profiles enable row level security;

create policy "anyone_can_read_profile" on profiles
    for select using (true);

create policy "owner_can_edit_own_profile" on profiles 
    for update using ((select auth.uid()) = id);

create function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = ''
as $$
begin
  insert into public.profiles (id, first_name, last_name, email, role)
  values (new.id, new.raw_user_meta_data ->> 'first_name', new.raw_user_meta_data ->> 'last_name', new.email, (new.raw_user_meta_data ->> 'role')::public.user_role);
  return new;
end;
$$;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();