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
| Forge | future specialization/variant layer |
| Rewards | match, chest/Forge Crate, mastery, events, season |
| Events | match-environment events are separate from LiveOps events |
| Competition | configurable Ruleset + Normalization; tournaments later |
| Analytics | versioned event schema |
| LiveOps | Event, Season, Rotation contracts |

## Architectural invariant

The engine must not branch on content count or content identity. A new card, hero or arena is data first.

Examples:

- Card #26 must not require a new branch in `CardRuntime`.
- Hero #9 must not require a new branch in combat architecture.
- Arena #16 must not require a new branch in arena orchestration.

If a new content item requires a system-code change, the dependency must be reviewed before normal content expansion continues.

## Strategic relationship model

The architecture supports generic relationships between:

`HERO + CARD + CARD + ARENA + EVENT`

through tags, definitions and rules. Individual combinations must not be hardcoded when a reusable rule can express them.

## Progression principle

`ARENA → NOVO CONTEÚDO → NOVAS POSSIBILIDADES ESTRATÉGICAS`

Unlock distribution is data-driven. The combat engine does not know why a card was unlocked or at which Trophy Road step it appears.

## Mastery / Forge principle

Mastery exists independently for cards, heroes and arenas. Forge is prepared as a future specialization/variant contract.

Rewards can be cosmetic, emotes, badges, effects, animations, variants or controlled power changes. Any power-bearing variant must expose a normalization policy for competitive modes.

## Event separation

1. **MATCH ENVIRONMENT EVENT** — occurs inside a battle and is subject to telegraph/warning/resolution rules.
2. **LIVE OPS EVENT** — meta/content event with schedule, rewards and ruleset.

They are different contracts and must remain independent.

## Competitive principle

Normal progression may retain player progression. Competitive modes can apply a configurable normalized Ruleset to hero/card levels and future power variables.

Tournaments, leagues, leaderboards, matchmaking, replays and anti-cheat are later systems. The foundation only defines contracts so they do not force a combat refactor.
