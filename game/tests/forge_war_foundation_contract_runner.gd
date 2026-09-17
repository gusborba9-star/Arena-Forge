extends SceneTree
const RunnerExit = preload("res://tests/support/runner_exit.gd")

func _init() -> void:
    var failures: Array[String] = []

    var forge := ForgeGuildDefinition.create({
        "id": "forge_alpha",
        "name": "Forge Alpha",
        "leader_id": "player_1",
        "officer_ids": ["player_2"],
        "members": ["player_1", "player_2"]
    })
    _check(forge["id"] == "forge_alpha", "Forge must have stable id", failures)
    _check(forge.has("members") and forge.has("leader_id") and forge.has("officer_ids"), "Forge must expose membership roles", failures)
    _check(forge.has("statistics") and forge.has("rules") and forge.has("configuration") and forge.has("history"), "Forge must expose social state contracts", failures)

    var war := ForgeWarDefinitions.war({
        "id": "war_100",
        "season_id": "season_1",
        "participating_forges": ["forge_alpha", "forge_beta", "forge_gamma"],
        "war_arena_id": "war_arena_1",
        "ruleset_id": "war_rules_1"
    })
    for state in ["SCHEDULED", "PREPARATION", "ACTIVE", "FINALIZING", "COMPLETED"]:
        _check(ForgeWarDefinitions.is_valid_state(state), state + " must be a valid war state", failures)
    _check(war["participating_forges"].size() == 3, "Forge War must support multiple participating Forges", failures)
    _check(war.has("individual_contributions") and war.has("forge_trophies") and war.has("ranking") and war.has("rewards"), "Forge War must expose aggregate result contracts", failures)

    var cycle := ForgeWarDefinitions.initial_cycle()
    _check(cycle["preparation_seconds"] == 86400, "initial preparation must be configurable at 24h", failures)
    _check(cycle["active_seconds"] == 172800, "initial active war must be configurable at 48h", failures)

    var war_arena := WarArenaDefinition.create({"id": "war_arena_10", "terrain": "forge_ring", "hazards": ["ember_field"], "events": ["forge_surge"], "objectives": ["hold_zone"]})
    _check(war_arena.has("terrain") and war_arena.has("hazards") and war_arena.has("events") and war_arena.has("rules") and war_arena.has("modifiers") and war_arena.has("objectives"), "War Arena must be gameplay data, not presentation only", failures)

    var rules := WarRulesetDefinitions.create({"id": "war_rules_1", "battle_attempts": {"per_player": 3}, "scoring_ruleset_id": "score_1", "contribution_ruleset_id": "contrib_1"})
    _check(rules.has("hero_level_normalization") and rules.has("card_level_normalization"), "War Ruleset must support normalization", failures)
    _check(rules.has("deck_restrictions") and rules.has("card_restrictions") and rules.has("hero_restrictions"), "War Ruleset must support restrictions", failures)
    _check(rules["battle_attempts"]["per_player"] == 3, "War attempts must be configurable", failures)

    var scoring := WarScoringDefinitions.create({"id": "score_1", "victory": {"points": 10}, "limits": {"per_player": 30}, "multipliers": {"objective": 1.5}})
    _check(scoring.has("victory") and scoring.has("defeat") and scoring.has("strength_difference") and scoring.has("objectives"), "War scoring must be ruleset driven", failures)
    _check(scoring.has("bonuses") and scoring.has("limits") and scoring.has("multipliers"), "War scoring must expose configurable modifiers and limits", failures)

    var contribution := WarContributionDefinitions.create({"id": "contrib_1", "metrics": ["victories", "damage", "objectives"], "individual_limits": {"daily": 3}})
    _check(contribution["metrics"].size() == 3, "War contribution metrics must be data-driven", failures)
    _check(contribution.has("individual_limits") and contribution.has("forge_limits") and contribution.has("eligibility"), "War contribution must support fairness limits", failures)

    var ranking := WarRankingDefinition.create({"id": "ranking_1", "tiebreakers": ["objectives", "contribution"]})
    _check(ranking.has("entries") and ranking.has("tiebreakers") and ranking.has("finalized"), "War Ranking must support deterministic finalization", failures)

    var rewards := WarRewardsDefinitions.create()
    _check(rewards.has("placement_rewards") and rewards.has("participation_rewards") and rewards.has("individual_contribution_rewards"), "War Rewards must support multiple reward paths", failures)
    _check(rewards.has("objective_rewards") and rewards.has("forge_rewards"), "War Rewards must support collective and objective rewards", failures)
    _check(str(rewards["id"]) != "" and str(rewards["idempotency_key_policy"]) != "", "War Rewards must define stable id and idempotency policy", failures)

    var season := SeasonDefinitions.create({"id": "season_1", "war_ids": ["war_100"], "special_arena_id": "war_arena_10"})
    _check(season["war_ids"].size() == 1, "Season must reference wars", failures)
    _check(season.has("ruleset_id") and season.has("rewards_id") and season.has("ranking"), "Season must expose war meta contracts", failures)

    var catalog := ContentCatalog.new()
    catalog.register_forge(forge)
    catalog.register_forge_war(war)
    catalog.register_war_arena(war_arena)
    catalog.register_war_ruleset(rules)
    catalog.register_war_scoring_ruleset(scoring)
    catalog.register_war_contribution_ruleset(contribution)
    catalog.register_war_rewards(rewards)
    catalog.register_season(season)
    _check(catalog.forges.has("forge_alpha"), "ContentCatalog must register Forge data", failures)
    _check(catalog.forge_wars.has("war_100"), "ContentCatalog must register Forge War data", failures)
    _check(catalog.war_arenas.has("war_arena_10"), "ContentCatalog must register War Arena data", failures)
    _check(catalog.war_rulesets.has("war_rules_1"), "ContentCatalog must register War Ruleset data", failures)
    _check(catalog.war_scoring_rulesets.has("score_1"), "ContentCatalog must register scoring rules", failures)
    _check(catalog.war_contribution_rulesets.has("contrib_1"), "ContentCatalog must register contribution rules", failures)
    _check(catalog.war_rewards.has(rewards["id"]), "ContentCatalog must register War Rewards by id", failures)
    _check(catalog.seasons.has("season_1"), "ContentCatalog must register Season data", failures)

    for event_name in ["forge_created", "forge_joined", "forge_left", "forge_war_joined", "forge_war_started", "forge_war_battle", "forge_war_contribution", "forge_war_completed", "forge_war_rewarded"]:
        _check(AnalyticsContract.is_supported(event_name), "analytics must support " + event_name, failures)
        var event := AnalyticsContract.event(event_name, {"contract_test": true})
        _check(int(event["schema_version"]) == AnalyticsContract.SCHEMA_VERSION, "analytics schema version must be stable", failures)

    _check(ForgeWarDefinitions.is_valid_state("INVALID") == false, "invalid war state must be rejected", failures)

    if failures.is_empty():
        RunnerExit.success(self, "ARENA_FORGE_FORGE_WAR_FOUNDATION_OK forge=contract war=contract arena=contract rulesets=contract season=contract analytics=9")
    else:
        failures = failures.map(func(f): return "FORGE WAR FOUNDATION FAILURE: " + f)
        RunnerExit.failure(self, failures)

func _check(condition: bool, message: String, failures: Array[String]) -> void:
    if not condition:
        failures.append(message)
