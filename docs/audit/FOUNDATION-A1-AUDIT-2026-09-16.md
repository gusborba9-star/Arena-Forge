# Arena Forge — Foundation + A1 + Forge War Audit

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
| Content Forge | IMPLEMENTED — future specialization contract only |
| Progression | IMPLEMENTED AS CONTRACT — no persistence/meta runtime yet |
| Rewards/Forge Crate | IMPLEMENTED AS CONTRACT — no economy runtime yet |
| Competitive | IMPLEMENTED AS CONTRACT — no tournaments/matchmaking yet |
| LiveOps | IMPLEMENTED AS CONTRACT — no production live ops yet |
| Analytics | IMPLEMENTED AS SCHEMA — no pipeline/dashboard yet |
| A1 runtime | IMPLEMENTED — behavioral runner added; CI validation required |
| Social Forge | ARCHITECTURE PREPARED — no production social system |
| Guerra das Forjas | ARCHITECTURE PREPARED — no production war system |
| War Arena | ARCHITECTURE PREPARED — data contract only |
| War Ruleset | ARCHITECTURE PREPARED — data contract only |
| War scoring/contribution | ARCHITECTURE PREPARED — data contracts only |
| War ranking/rewards | ARCHITECTURE PREPARED — data contracts only |
| Season linkage | ARCHITECTURE PREPARED — no season runtime |
| Hórus dependency | NO RESIDUAL RUNTIME DEPENDENCY FOUND |

## Forge naming decision

`ForgeDefinition` already represents the Content Forge/Specialization layer. To avoid semantic collision, the social entity is named technically as `ForgeGuildDefinition`, while the product-facing name remains **Forja**.

This preserves the product identity without coupling the social system to the content-specialization system.

## Forge War architecture

The social competitive foundation defines:

- `ForgeGuildDefinition`;
- `ForgeWarDefinitions`;
- `WarArenaDefinition`;
- `WarRulesetDefinitions`;
- `WarScoringDefinitions`;
- `WarContributionDefinitions`;
- `WarRankingDefinition`;
- `WarRewardsDefinitions`;
- `SeasonDefinitions`.

The war state machine is:

`SCHEDULED → PREPARATION → ACTIVE → FINALIZING → COMPLETED`.

The initial data configuration is 24h preparation + 48h active war + configurable finalization. The duration is not hardcoded as an immutable product rule.

The model is intentionally indirect/asynchronous:

`PLAYER → FORGE → INDIVIDUAL BATTLE → CONTRIBUTION → FORGE TROPHIES → WAR RANKING`.

No large-scale simultaneous combat is required by the architecture.

## Fairness contracts

The contracts expose future controls for:

- War Energy / Battle Attempts;
- individual contribution limits;
- Forge contribution limits;
- victory/defeat scoring;
- strength-difference modifiers;
- objectives;
- bonuses and multipliers;
- restrictions and normalization;
- deterministic ranking finalization;
- reward idempotency.

Production enforcement is deliberately not implemented yet.

## Content scalability

The ContentCatalog now has explicit collections for:

- Forges;
- Forge Wars;
- War Arenas;
- War Rulesets;
- War Scoring Rulesets;
- War Contribution Rulesets;
- War Rewards;
- Seasons.

The intended invariant is:

- Forge #2 → data, no new social engine class;
- ForgeWar #100 → data, no new war engine class;
- WarArena #10 → data, no new battle engine class.

## Behavioral foundation test

`game/tests/forge_war_foundation_contract_runner.gd` exercises construction, state validity, duration configuration, arena data, ruleset controls, scoring, contribution, ranking, rewards, season linkage, ContentCatalog registration and all nine Forge War analytics events.

The runner uses explicit failure collection and `quit(1)` to avoid false-green behavior.

## A1 implementation

`MatchRuntime` provides a deterministic battle-state contract around existing `MatchState`, `ArenaDirector`, `Telegraph`, `ArenaState`, `CombatSystem`, `MatchProgression` and `MatchRewards`.

The acceptance runner executes, rather than compares constants:

1. CONTROL → IGNITION → CATACLYSM → RESULT;
2. event request → telegraph → warning elapsed → resolution → arena mutation;
3. progressive cataclysm radius and inside/outside boundary;
4. CHASER/RANGED/TANK/SWARM/ELITE role behavior;
5. armor/damage/death/knockback/XP;
6. RESULT → deterministic rewards;
7. false-green protection through explicit failure collection and `quit(1)`.

## Validation status

A1 remains **IMPLEMENTED / VALIDATION PENDING** until the current HEAD completes the complete CI workflow with green Node and Godot jobs and the required A1/content/bootstrap markers.

The Forge War contract test is now part of CI and therefore must also compile and pass before the repository can be considered clean after this architectural change.

## Explicitly not implemented

No production store, real purchases, matchmaking, leaderboard, full tournament system, chat, social UI, invitations, notifications, production persistence, production war engine, production season engine, production battle UI, complete 25-card set, complete 8-hero set, complete 15-arena runtime, or production live ops were introduced.

## Hórus classification

No Hórus runtime dependency was added. Existing generic architecture remains usable. Hórus-specific domain logic remains excluded. External `velor-api` cutover remains a separate operational dependency.
