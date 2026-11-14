create table if not exists public.roadmap_progress (
  user_id uuid primary key references auth.users (id) on delete cascade,
  state jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.roadmap_progress enable row level security;

drop policy if exists "Users manage their own roadmap progress" on public.roadmap_progress;
create policy "Users manage their own roadmap progress"
  on public.roadmap_progress
  for all
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

grant select, insert, update on public.roadmap_progress to authenticated;

create or replace function public.set_roadmap_progress_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_roadmap_progress_updated_at on public.roadmap_progress;
create trigger set_roadmap_progress_updated_at
  before update on public.roadmap_progress
  for each row
  execute function public.set_roadmap_progress_updated_at();

do $$
begin
  if not exists (
    select 1
    from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'roadmap_progress'
  ) then
    execute 'alter publication supabase_realtime add table public.roadmap_progress';
  end if;
end;
$$;
