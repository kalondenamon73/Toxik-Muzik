-- Toxik Musik backend bootstrap for Supabase SQL Editor
create table if not exists public.tracks (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references auth.users(id) on delete cascade,
 title text not null check (length(title) between 1 and 120),
 artist text not null check (length(artist) between 1 and 120),
 genre text not null default 'Other',
 audio_url text not null,
 cover_url text,
 plays bigint not null default 0,
 created_at timestamptz not null default now()
);
alter table public.tracks enable row level security;
drop policy if exists "Public can read tracks" on public.tracks;
create policy "Public can read tracks" on public.tracks for select using (true);
drop policy if exists "Signed users add own tracks" on public.tracks;
create policy "Signed users add own tracks" on public.tracks for insert to authenticated with check (auth.uid()=user_id);
drop policy if exists "Owners delete tracks" on public.tracks;
create policy "Owners delete tracks" on public.tracks for delete to authenticated using (auth.uid()=user_id);
-- Set public buckets so audio/cover URLs can be streamed by visitors.
insert into storage.buckets(id,name,public,file_size_limit,allowed_mime_types)
values('music','music',true,26214400,array['audio/mpeg'])
on conflict(id) do update set public=true,file_size_limit=26214400,allowed_mime_types=array['audio/mpeg'];
insert into storage.buckets(id,name,public,file_size_limit,allowed_mime_types)
values('covers','covers',true,5242880,array['image/jpeg','image/png','image/webp'])
on conflict(id) do update set public=true,file_size_limit=5242880,allowed_mime_types=array['image/jpeg','image/png','image/webp'];
drop policy if exists "Public stream music" on storage.objects;
create policy "Public stream music" on storage.objects for select using(bucket_id='music');
drop policy if exists "Artists upload music to own folder" on storage.objects;
create policy "Artists upload music to own folder" on storage.objects for insert to authenticated with check(bucket_id='music' and (storage.foldername(name))[1]=auth.uid()::text);
drop policy if exists "Artists delete own music" on storage.objects;
create policy "Artists delete own music" on storage.objects for delete to authenticated using(bucket_id='music' and (storage.foldername(name))[1]=auth.uid()::text);
drop policy if exists "Public view covers" on storage.objects;
create policy "Public view covers" on storage.objects for select using(bucket_id='covers');
drop policy if exists "Artists upload own covers" on storage.objects;
create policy "Artists upload own covers" on storage.objects for insert to authenticated with check(bucket_id='covers' and (storage.foldername(name))[1]=auth.uid()::text);
drop policy if exists "Artists delete own covers" on storage.objects;
create policy "Artists delete own covers" on storage.objects for delete to authenticated using(bucket_id='covers' and (storage.foldername(name))[1]=auth.uid()::text);
