extends SceneTree
const RunnerExit = preload("res://tests/support/runner_exit.gd")

const EXPECTED_RUNTIME_CARDS := 16
const EXPECTED_RUNTIME_HEROES := 4
const EXPECTED_RUNTIME_ARENAS := 15

func _init() -> void:
    var failures: Array[String] = []
    var catalog := ContentCatalog.new()
    catalog.load_initial_content()

    _check_equal(catalog.card_count(), EXPECTED_RUNTIME_CARDS, "catalog.card_count", failures)
    _check_equal(catalog.hero_count(), EXPECTED_RUNTIME_HEROES, "catalog.hero_count", failures)
    _check_equal(catalog.arena_count(), EXPECTED_RUNTIME_ARENAS, "catalog.arena_count", failures)

    var launch_target := ProgressionDefinitions.launch_target()
    _check_int_min(launch_target.get("target_cards", -1), 25, "launch_target.target_cards", failures)
    _check_int_min(launch_target.get("target_heroes", -1), 8, "launch_target.target_heroes", failures)
    _check_equal(launch_target.get("target_arenas", -1), 15, "launch_target.target_arenas", failures)
    _check_equal(launch_target.get("deck_size", -1), 8, "launch_target.deck_size", failures)
    _check_equal(launch_target.get("hand_size", -1), 4, "launch_target.hand_size", failures)

    _validate_cards(catalog.cards, failures)
    _validate_heroes(catalog.heroes, failures)
    _validate_arenas(catalog.arenas, failures)
    _validate_cross_contracts(catalog, failures)

    if failures.is_empty():
        RunnerExit.success(self, "ARENA_FORGE_CONTENT_FOUNDATION_OK cards=16 validated heroes=4 fixtures arenas=15 launch cards>=25 heroes>=8")
        return

    failures = failures.map(func(f): return "CONTENT FOUNDATION FAILURE: " + f)
    RunnerExit.failure(self, failures)

func _validate_cards(cards: Dictionary, failures: Array[String]) -> void:
    for card_id in cards.keys():
        var card: Dictionary = cards[card_id]
        var prefix := "card[%s]" % str(card_id)
        _check(str(card.get("id", "")) == str(card_id), prefix + ".id must match catalog key", failures)
        _check_array_non_empty(card.get("tags", []), prefix + ".tags", failures)
        _check_array_non_empty(card.get("synergy_tags", []), prefix + ".synergy_tags", failures)
        _check_int_min(card.get("unlock_arena", 0), 1, prefix + ".unlock_arena", failures)
        _check(str(card.get("mastery_id", "")) != "", prefix + ".mastery_id", failures)
        _check_array_non_empty(card.get("effects", []), prefix + ".effects", failures)

        var definition := CardDefinition.from_dict(card)
        _check_equal(definition.id, str(card_id), prefix + ".definition.id", failures)
        _check_equal(definition.energy_cost, int(card.get("energy_cost", -1)), prefix + ".definition.energy_cost", failures)
        _check_equal(definition.mastery_id, str(card.get("mastery_id", "")), prefix + ".definition.mastery_id", failures)
        _check(definition.effects.size() > 0, prefix + ".definition.effects", failures)
        _check(CardSynergy.tags_for(card).size() > 0, prefix + ".synergy resolution", failures)

func _validate_heroes(heroes: Dictionary, failures: Array[String]) -> void:
    for hero_id in heroes.keys():
        var hero: Dictionary = heroes[hero_id]
        var prefix := "hero[%s]" % str(hero_id)
        _check(str(hero.get("id", "")) == str(hero_id), prefix + ".id must match catalog key", failures)
        _check(str(hero.get("ability_id", "")) != "", prefix + ".ability_id", failures)
        _check_array_non_empty(hero.get("tags", []), prefix + ".tags", failures)
        _check(str(hero.get("mastery_id", "")) != "", prefix + ".mastery_id", failures)

        var definition := HeroDefinition.from_dict(hero)
        _check_equal(definition.id, str(hero_id), prefix + ".definition.id", failures)
        _check_equal(definition.ability_id, str(hero.get("ability_id", "")), prefix + ".definition.ability_id", failures)

func _validate_arenas(arenas: Dictionary, failures: Array[String]) -> void:
    for arena_id in arenas.keys():
        var arena: Dictionary = arenas[arena_id]
        var prefix := "arena[%s]" % str(arena_id)
        _check(str(arena.get("id", "")) == str(arena_id), prefix + ".id must match catalog key", failures)
        _check(str(arena.get("name", "")) != "", prefix + ".name", failures)
        _check(str(arena.get("environment", "")) != "", prefix + ".environment", failures)
        _check(str(arena.get("terrain", "")) != "", prefix + ".terrain", failures)
        _check_array_non_empty(arena.get("hazards", []), prefix + ".hazards", failures)
        _check(arena.has("unlock_requirement"), prefix + ".unlock_requirement", failures)

        var definition := ArenaDefinition.from_dict(arena)
        _check_equal(definition.id, str(arena_id), prefix + ".definition.id", failures)
        _check_equal(definition.environment, str(arena.get("environment", "")), prefix + ".definition.environment", failures)

func _validate_cross_contracts(catalog: ContentCatalog, failures: Array[String]) -> void:
    var first_card: Dictionary = catalog.cards["meteor"]
    var meteor_definition := CardDefinition.from_dict(first_card)
    var arena_card := ArenaCard.from_definition(first_card)
    _check_equal(arena_card.id, meteor_definition.id, "meteor ArenaCard.id", failures)
    _check_equal(arena_card.energy_cost, float(meteor_definition.energy_cost), "meteor ArenaCard.energy_cost", failures)
    _check(arena_card.effects.size() == meteor_definition.effects.size(), "meteor ArenaCard.effects preserve definition", failures)

    var mastery_fixture := MasteryDefinition.from_dict({
        "id": first_card["mastery_id"],
        "target_type": "card",
        "target_id": first_card["id"],
        "milestones": [{"threshold": 1}],
        "reward_policy": {"type": "choice"}
    })
    _check_equal(mastery_fixture.id, str(first_card["mastery_id"]), "mastery definition id", failures)
    _check_equal(mastery_fixture.target_id, str(first_card["id"]), "mastery definition target", failures)

    var reward_schema := RewardDefinitions.reward_schema()
    var choice_policy: Dictionary = reward_schema.get("choice_policy", {})
    _check(bool(choice_policy.get("enabled", false)), "rewards.choice_policy.enabled", failures)
    _check_int_min(choice_policy.get("min_options", 0), 2, "rewards.choice_policy.min_options", failures)
    _check_int_min(choice_policy.get("max_options", 0), int(choice_policy.get("min_options", 0)), "rewards.choice_policy.max_options", failures)

    var competitive := CompetitiveDefinitions.normalized_ruleset()
    var normalization: Dictionary = competitive.get("normalization", {})
    _check_equal(normalization.get("card_level", ""), "fixed", "competitive.normalization.card_level", failures)
    _check_equal(normalization.get("hero_level", ""), "fixed", "competitive.normalization.hero_level", failures)

    _check(AnalyticsContract.is_supported("card_played"), "analytics.card_played", failures)
    _check(AnalyticsContract.is_supported("match_started"), "analytics.match_started", failures)
    _check(AnalyticsContract.is_supported("reward_received"), "analytics.reward_received", failures)

func _check(condition: bool, message: String, failures: Array[String]) -> void:
    if not condition:
        failures.append(message + " | expected=true | found=false")

func _check_equal(actual: Variant, expected: Variant, message: String, failures: Array[String]) -> void:
    if actual != expected:
        failures.append(message + " | expected=%s | found=%s" % [str(expected), str(actual)])

func _check_int_min(actual: Variant, minimum: int, message: String, failures: Array[String]) -> void:
    var numeric := int(actual)
    if numeric < minimum:
        failures.append(message + " | expected>=%d | found=%d" % [minimum, numeric])

func _check_array_non_empty(value: Variant, message: String, failures: Array[String]) -> void:
    if not (value is Array) or (value as Array).is_empty():
        failures.append(message + " | expected=non-empty array | found=%s" % str(value))
