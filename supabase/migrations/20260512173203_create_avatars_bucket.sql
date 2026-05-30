insert into storage.buckets
  (id, name, public, allowed_mime_types, file_size_limit)
values
  ('avatars', 'avatars', true, '{"image/jpeg", "image/png"}',  5);

create policy "Allow authenticated uploads"
on storage.objects
for insert
to authenticated
with check (
  bucket_id = 'avatars' and
  (storage.foldername(name))[1] = (select auth.jwt()->>'sub') and 
  storage.filename(name) = 'avatar'
);