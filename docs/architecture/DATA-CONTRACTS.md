# Arena Forge — Data Contracts

## 1. Dois escopos de produto

### Validated Prototype Scope
`16-card validated runtime scope` permanece preservado como baseline técnico. Os 16 cards continuam sendo executados pelos contratos Godot já validados.

### Launch Product Target
- 25+ cards;
- 8+ heroes;
- 15 arenas;
- 1 hero por partida;
- deck de 8 cards;
- mão de 4 cards;
- próximo card entra automaticamente após uso;
- energia compartilhada;
- arena dinâmica;
- eventos ambientais telegráficos;
- progressão por arenas;
- coleção e desbloqueios;
- rewards, chests/Forge Crates e mastery;
- eventos e temporadas;
- competição com Ruleset/Normalization;
- analytics e live ops preparados para expansão.

25 é o mínimo de lançamento, não o limite estrutural.

## 2. Content contracts

### HeroDefinition
`id, role, hp, damage, speed, armor, attack_range, ability_id, tags, mastery_id, specialization_id`.

O herói é entidade jogável e **não é carta**. Uma partida possui exatamente um herói controlado pelo jogador.

### CardDefinition
`id, name, rarity, category, energy_cost, cooldown, effects, tags, synergy_tags, unlock_arena, mastery_id, forge_id`.

O runtime validado permanece em `CardDefinitions → ArenaCard → ArenaDeck → CardRuntime → CardEffectResolver`.

### ArenaDefinition
`id, name, environment, terrain, hazards, elements, tile_types, environmental_rules, events, enemy_pool, spawn_rules, destructibles, unlock_requirement, special_rules, synergy_tags, mastery_id`.

Arena é sistema de gameplay, não apenas apresentação.

## 3. Foundation contracts prepared, not full systems

- `CardSynergy`: vocabulário e resolução genérica de tags entre hero/card/arena.
- `MasteryDefinition`: contrato compartilhado para Card/Hero/Arena Mastery.
- `ForgeDefinition`: contrato futuro para especializações/variantes e política de normalização.
- `ProgressionDefinitions`: target de lançamento e Trophy Road data-driven.
- `RewardDefinitions`: tipos de recompensa e Forge Crate com suporte a escolha de N.
- `CompetitiveDefinitions`: Ruleset e Normalization configuráveis; torneios são contratos futuros.
- `LiveOpsDefinitions`: Event, Season e Rotation separados do evento ambiental da partida.
- `AnalyticsContract`: schema versionado e extensível para eventos de produto.

Esses contratos não implementam loja, matchmaking, leaderboard, torneios completos, monetização ou live ops.

## 4. Escalabilidade obrigatória

O núcleo deve permanecer estável enquanto o conteúdo cresce:

- cards: `25 → 40 → 60 → 100+`;
- heroes: `8 → 10 → 15+`;
- arenas: `15 → futuras arenas`.

Adicionar conteúdo deve ser uma alteração de dados/fixtures, não uma alteração no motor de combate ou nas regras de coleção.
