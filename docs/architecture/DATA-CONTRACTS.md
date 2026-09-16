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

## 4. Forge / Social Competitive contracts

### ForgeGuildDefinition
Unidade social coletiva do Arena Forge. O nome técnico `ForgeGuildDefinition` evita conflito com o já existente `ForgeDefinition`, que representa especialização/Forge de conteúdo.

Contrato:
`id, name, description, emblem, members, leader_id, officer_ids, level, trophies, season_id, statistics, rules, configuration, history`.

Não implementa UI, chat, convite, busca ou persistência de produção.

### ForgeWarDefinitions
Contrato de `Guerra das Forjas` com:
`id, season_id, status, start_at, preparation_at, battle_start_at, end_at, duration_seconds, participating_forges, ruleset_id, war_arena_id, battles, individual_contributions, forge_trophies, ranking, rewards`.

Estados:
`SCHEDULED → PREPARATION → ACTIVE → FINALIZING → COMPLETED`.

O ciclo inicial de referência é configurável em dados: preparação 24h, guerra ativa 48h e finalização configurável.

### WarArenaDefinition
Arena especial independente das arenas normais:
`id, name, terrain, hazards, events, rules, modifiers, objectives, visual_identity`.

### WarRulesetDefinitions
Contrato para:
- hero/card normalization;
- deck/card/hero restrictions;
- arena modifiers;
- event frequency;
- battle attempts / War Energy;
- scoring;
- contribution;
- objectives;
- rewards.

### WarScoringDefinitions
Permite controlar sem hardcode:
`victory, defeat, strength_difference, objectives, bonuses, limits, max_contribution, multipliers`.

### WarContributionDefinitions
Permite definir métricas, elegibilidade, limites individuais/coletivos, agregação e contribuição por objetivos.

### WarRankingDefinition
Suporta múltiplas Forjas, entradas, score, desempates e fechamento determinístico/finalizado.

### WarRewardsDefinitions
Suporta placement, participation, individual contribution, objectives e Forge rewards. Inclui política de idempotência para futura prevenção de duplicação.

### SeasonDefinitions
Uma Season pode referenciar múltiplas guerras, ruleset, arena especial, rewards, ranking e identidade visual.

A arquitetura social/competitiva é apenas fundação. Não implementa matchmaking, leaderboard social, chat, persistência, notificações ou guerra real nesta etapa.

## 5. Analytics social

`AnalyticsContract` permanece versionado e agora suporta:
- `forge_created`
- `forge_joined`
- `forge_left`
- `forge_war_joined`
- `forge_war_started`
- `forge_war_battle`
- `forge_war_contribution`
- `forge_war_completed`
- `forge_war_rewarded`

## 6. Escalabilidade obrigatória

O núcleo deve permanecer estável enquanto o conteúdo cresce:

- cards: `25 → 40 → 60 → 100+`;
- heroes: `8 → 10 → 15+`;
- arenas: `15 → futuras arenas`;
- Forjas: `Forge #2 → Forge #N`;
- guerras: `ForgeWar #100 → ForgeWar #N`;
- War Arenas: `WarArena #10 → WarArena #N`.

Adicionar conteúdo deve ser uma alteração de dados/fixtures, não uma alteração no motor de combate, guerra ou regras de coleção.

## 7. Fairness / integridade futura

Os contratos devem permitir:
- limites de contribuição;
- limites de batalhas/War Energy;
- idempotência;
- resultados imutáveis após fechamento;
- fechamento determinístico;
- ranking reproduzível.

Segurança de produção completa e anti-exploit permanecem sistemas futuros.
