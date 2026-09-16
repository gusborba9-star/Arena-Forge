# Arena Forge — Product Foundation

## Product target

Arena Forge is being built in layers. The validated prototype is not the launch product.

### Validated Prototype Scope
`16-card validated runtime scope`

This scope is historical and remains a regression baseline. It must not be silently replaced by launch-target numbers.

### Launch Product Target

| Domain | Launch target |
|---|---|
| Cards | 25+ |
| Heroes | 8+ |
| Arenas | 15 |
| Match hero | exactly 1 controlled hero |
| Deck | 8 cards |
| Hand | 4 cards |
| Energy | shared |
| Arena | dynamic gameplay system |
| Match events | telegraphed |
| Progression | arena-based, data-driven |
| Collection | cards, heroes, cosmetics/emotes and future content |
| Mastery | card, hero, arena |
| Forge | future specialization/variant layer + social Forge foundation |
| Rewards | match, chest/Forge Crate, mastery, events, season and future Forge War |
| Events | match-environment events are separate from LiveOps events |
| Competition | configurable Ruleset + Normalization; tournaments later |
| Analytics | versioned event schema |
| LiveOps | Event, Season, Rotation contracts |
| Social | Forge foundation; UI and production persistence later |
| Collective competition | Guerra das Forjas foundation; asynchronous/indirect model |

## Architectural invariant

The engine must not branch on content count or content identity. A new card, hero or arena is data first.

Examples:

- Card #26 must not require a new branch in `CardRuntime`.
- Hero #9 must not require a new branch in combat architecture.
- Arena #16 must not require a new branch in arena orchestration.
- Forge #2 must not require a new social engine class.
- ForgeWar #100 must not require a new war engine class.
- WarArena #10 must be data, not a new battle engine.

If a new content item requires a system-code change, the dependency must be reviewed before normal content expansion continues.

## Strategic relationship model

The architecture supports generic relationships between:

`HERO + CARD + CARD + ARENA + EVENT`

and, at the social layer:

`PLAYER → FORGE → FORGE WAR → INDIVIDUAL BATTLE → CONTRIBUTION → WAR RANKING`

through tags, definitions and rules. Individual combinations must not be hardcoded when a reusable rule can express them.

## Progression principle

`ARENA → NOVO CONTEÚDO → NOVAS POSSIBILIDADES ESTRATÉGICAS`

Unlock distribution is data-driven. The combat engine does not know why a card was unlocked or at which Trophy Road step it appears.

## Mastery / Forge principle

Mastery exists independently for cards, heroes and arenas. Content Forge is prepared as a future specialization/variant contract. Social Forge is a separate collective entity and must not be conflated with Content Forge/Specialization.

Rewards can be cosmetic, emotes, badges, effects, animations, variants or controlled power changes. Any power-bearing variant must expose a normalization policy for competitive modes.

## Event separation

1. **MATCH ENVIRONMENT EVENT** — occurs inside a battle and is subject to telegraph/warning/resolution rules.
2. **LIVE OPS EVENT** — meta/content event with schedule, rewards and ruleset.
3. **FORGE WAR EVENT** — collective competitive event using scheduled war state, individual battles and aggregated contribution.

These contracts remain independent.

## Competitive principle

Normal progression may retain player progression. Competitive modes can apply a configurable normalized Ruleset to hero/card levels and future power variables.

### Guerra das Forjas
The social competitive foundation defines:
- ForgeGuildDefinition;
- ForgeWarDefinitions;
- WarArenaDefinition;
- WarRulesetDefinitions;
- WarScoringDefinitions;
- WarContributionDefinitions;
- WarRankingDefinition;
- WarRewardsDefinitions;
- SeasonDefinitions.

The war lifecycle is configurable:
`SCHEDULED → PREPARATION → ACTIVE → FINALIZING → COMPLETED`.

The prepared initial cycle is 24h preparation + 48h active war, but those values are configuration rather than immutable product rules.

Each player participates through individual battles. Results produce individual contribution and feed collective Forge trophies/ranking. Battle attempts/War Energy, objectives, restrictions, normalization and scoring are ruleset-driven.

Production matchmaking, leaderboard, chat, social UI, persistence, notifications and complete anti-exploit are later systems. The foundation exists specifically to prevent those systems from forcing a combat-engine refactor.

## Foundation status discipline

Contracts can be **ARCHITECTURE PREPARED** without being **IMPLEMENTED** or **VALIDATED**. A production system requires implementation, behavioral testing, CI/regression evidence and documented closure.
