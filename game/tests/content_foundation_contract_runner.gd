extends SceneTree

func _init() -> void:
    var failures: Array[String] = []
    var catalog := ContentCatalog.new()
    catalog.load_initial_content()
    _check(catalog.card_count() == 16, "validated runtime content must remain 16 cards", failures)
    _check(catalog.hero_count() == 4, "current hero fixture must remain 4", failures)
    _check(catalog.arena_count() == 15, "launch arena catalog must contain 15 definitions", failures)
    _check(ProgressionDefinitions.launch_target()["target_cards"] >= 25, "launch target must be 25+ cards", failures)
    _check(ProgressionDefinitions.launch_target()["target_heroes"] >= 8, "launch target must be 8+ heroes", failures)
    _check(ProgressionDefinitions.launch_target()["target_arenas"] == 15, "launch target must contain 15 arenas", failures)
    _check(ProgressionDefinitions.launch_target()["deck_size"] == 8, "deck size contract must remain 8", failures)
    _check(ProgressionDefinitions.launch_target()["hand_size"] == 4, "hand size contract must remain 4", failures)
    var first_card: Dictionary = catalog.cards["meteor"]
    _check(first_card.has("tags") and first_card.has("unlock_arena") and first_card.has("mastery_id"), "cards must expose scalable metadata", failures)
    var hero: Dictionary = catalog.heroes["elf"]
    _check(hero.has("tags") and hero.has("ability_id") and hero.has("mastery_id"), "heroes must expose scalable metadata", failures)
    var arena: Dictionary = catalog.arenas["arena_1"]
    _check(arena.has("events") and arena.has("hazards") and arena.has("unlock_requirement"), "arenas must expose gameplay identity", failures)
    _check(CardSynergy.tags_for(first_card).size() > 0, "card synergy tags must resolve generically", failures)
    _check(RewardDefinitions.reward_schema()["choice_policy"]["enabled"], "rewards must support choice-of-N", failures)
    _check(CompetitiveDefinitions.normalized_ruleset()["normalization"]["card_level"] == "fixed", "competitive normalization must be configurable", failures)
    _check(AnalyticsContract.is_supported("card_played"), "analytics schema must support core events", failures)
    if failures.is_empty():
        print("ARENA_FORGE_CONTENT_FOUNDATION_OK cards=16 validated heroes=4 fixtures arenas=15 launch cards>=25 heroes>=8")
        quit(0)
    for failure in failures:
        push_error("CONTENT FOUNDATION FAILURE: " + failure)
    quit(1)

func _check(condition: bool, message: String, failures: Array[String]) -> void:
    if not condition:
        failures.append(message)
