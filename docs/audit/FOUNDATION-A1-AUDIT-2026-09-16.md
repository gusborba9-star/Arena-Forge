# Arena Forge — Foundation + A1 Audit

**Baseline:** post-foundation implementation on `main`
**Date:** 2026-09-16

## Executive state

| Area | State |
|---|---|
| Validated prototype | VALIDATED — 16-card runtime scope preserved |
| Launch target | IMPLEMENTED AS PRODUCT CONTRACT — 25+ cards, 8+ heroes, 15 arenas |
| Content architecture | IMPLEMENTED — data-driven definitions/catalog |
| Synergy | IMPLEMENTED — generic tag resolver |
| Mastery | IMPLEMENTED — shared contract |
| Forge | IMPLEMENTED — future specialization contract only |
| Progression | IMPLEMENTED AS CONTRACT — no persistence/meta runtime yet |
| Rewards/Forge Crate | IMPLEMENTED AS CONTRACT — no economy runtime yet |
| Competitive | IMPLEMENTED AS CONTRACT — no tournaments/matchmaking yet |
| LiveOps | IMPLEMENTED AS CONTRACT — no production live ops yet |
| Analytics | IMPLEMENTED AS SCHEMA — no pipeline/dashboard yet |
| A1 runtime | IMPLEMENTED — behavioral runner added; CI validation required |
| Hórus dependency | NO RESIDUAL RUNTIME DEPENDENCY FOUND |

## A1 implementation

`MatchRuntime` now provides a deterministic battle-state contract around existing `MatchState`, `ArenaDirector`, `Telegraph`, `ArenaState`, `CombatSystem`, `MatchProgression` and `MatchRewards`.

The acceptance runner executes, rather than compares constants:

1. CONTROL → IGNITION → CATACLYSM → RESULT;
2. event request → telegraph → warning elapsed → resolution → arena mutation;
3. progressive cataclysm radius and inside/outside boundary;
4. CHASER/RANGED/TANK/SWARM/ELITE role behavior;
5. armor/damage/death/knockback/XP;
6. RESULT → deterministic rewards;
7. false-green protection through explicit failure collection and `quit(1)`.

## Content foundation

The catalog remains compatible with the historical 16-card runtime while launch contracts now formalize:

- `HeroDefinition`;
- `CardDefinition`;
- `ArenaDefinition`;
- `CardSynergy`;
- `MasteryDefinition`;
- `ForgeDefinition`;
- `ProgressionDefinitions`;
- `RewardDefinitions`;
- `CompetitiveDefinitions`;
- `LiveOpsDefinitions`;
- `AnalyticsContract`.

15 arena definitions exist as launch content targets. Four hero definitions remain the current fixture set; eight is the launch minimum, not a claim that eight complete heroes exist.

## Refactorability test

The intended invariant is:

- Card #26 → data addition, no engine branch.
- Hero #9 → data addition, no combat architecture branch.
- Arena #16 → data addition/definition, no arena orchestration branch.

This invariant is now represented by the content model and catalog, but complete production acceptance still requires future content fixture tests at scale.

## Explicitly not implemented

No production store, real purchases, matchmaking, leaderboard, full tournament system, social layer, production battle UI, complete 25-card set, complete 8-hero set, complete 15-arena runtime, or production live ops were introduced.

## Hórus classification

No Hórus runtime dependency was added. Existing generic architecture remains usable. Hórus-specific domain logic remains excluded. External `velor-api` cutover remains a separate operational dependency.

## Validation rule

The repository is not allowed to claim A1 VALIDATED until the new CI run is green and its logs contain the A1, content-foundation and bootstrap markers.
