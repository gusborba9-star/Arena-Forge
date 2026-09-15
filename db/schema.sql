create table if not exists game_profiles (id uuid primary key references auth.users(id) on delete cascade, trophies integer not null default 0, current_arena integer not null default 1, created_at timestamptz not null default now());
create table if not exists game_decks (id uuid primary key default gen_random_uuid(), user_id uuid not null references auth.users(id) on delete cascade, hero_id text not null, card_ids jsonb not null, updated_at timestamptz not null default now());
create index if not exists game_decks_user_id_idx on game_decks(user_id);
