extends SceneTree

func _init() -> void:
    var failures: Array[String] = []
    var catalog := ContentCatalog.new()
    catalog.load_initial_content()

    var card_26 := {"id":"card_26_fixture","name":"Card 26 Fixture","rarity":"common","category":"damage","energy_cost":2,"tags":["OFFENSE"],"synergy_tags":["OFFENSE"],"unlock_arena":4,"mastery_id":"card_26_mastery","effects":[{"kind":"damage","value":20,"area":100}]}
    var hero_9 := {"id":"hero_9_fixture","role":"fighter","hp":140.0,"damage":18.0,"speed":210.0,"armor":1.0,"attack_range":90.0,"ability_id":"hero_9_ability","tags":["OFFENSE"],"mastery_id":"hero_9_mastery","specialization_id":"hero_9_specialization"}
    var arena_16 := {"id":"arena_16_fixture","name":"Arena 16 Fixture","environment":"fixture","terrain":"open","hazards":["fixture_hazard"],"elements":["earth"],"events":[{"id":"fixture_event","warning_seconds":1.0,"cooldown_seconds":10.0,"mutation":"fixture_mutation"}],"unlock_requirement":{"trophies":7000},"mastery_id":"arena_16_mastery","cataclysm":{"starts_at":2.0,"duration":4.0,"start_radius":600.0,"end_radius":120.0}}
    catalog.register_card(card_26)
    catalog.register_hero(hero_9)
    catalog.register_arena(arena_16)

    var war_arena := WarArenaDefinition.create({"id":"war_arena_2_fixture","name":"War Arena 2 Fixture","terrain":"fixture","hazards":["fixture"],"events":[{"id":"war_fixture_event"}],"rules":{},"modifiers":[],"objectives":[],"visual_identity":{}})
    var forge := ForgeGuildDefinition.create({"id":"forge_2_fixture","name":"Forge 2 Fixture","leader_id":"player_fixture"})
    var war := ForgeWarDefinitions.war({"id":"forge_war_100_fixture","season_id":"season_fixture","status":"SCHEDULED","participating_forges":[forge.id],"war_arena_id":war_arena.id})
    catalog.register_war_arena(war_arena)
    catalog.register_forge(forge)
    catalog.register_forge_war(war)

    _check(catalog.cards.has(card_26.id), "Card #26 fixture must register through ContentCatalog", failures)
    _check(catalog.heroes.has(hero_9.id), "Hero #9 fixture must register through ContentCatalog", failures)
    _check(catalog.arenas.has(arena_16.id), "Arena #16 fixture must register through ContentCatalog", failures)
    _check(catalog.war_arenas.has(war_arena.id), "additional WarArena must register through ContentCatalog", failures)
    _check(catalog.forges.has(forge.id), "additional Forge must register through ContentCatalog", failures)
    _check(catalog.forge_wars.has(war.id), "additional ForgeWar must register through ContentCatalog", failures)

    var runtime_card := ArenaCard.from_definition(card_26)
    _check(runtime_card.id == card_26.id, "Card #26 must become a real ArenaCard without engine specialization", failures)
    _check(runtime_card.energy_cost == 2.0, "Card #26 energy must come from its definition", failures)
    _check(runtime_card.effects.size() == 1, "Card #26 effect definition must survive runtime construction", failures)

    var deck := ArenaDeck.new()
    var cards: Array[ArenaCard] = []
    for i in range(ArenaDeck.DECK_SIZE):
        cards.append(runtime_card if i == 0 else ArenaCard.from_definition(card_26))
    _check(deck.set_deck(cards), "Card #26 fixture must enter the generic deck contract", failures)
    _check(deck.hand.size() == ArenaDeck.HAND_SIZE, "Card #26 deck must populate the generic hand contract", failures)
    var runtime := CardRuntime.new()
    runtime.configure(deck)
    var energy := EnergyPool.new()
    energy.configure(10.0, 1.5)
    var enemy := ArenaEnemy.new()
    enemy.configure(ArenaEnemy.Role.CHASER, 50.0, 5.0, 90.0, 0.0)
    enemy.position = Vector2.ZERO
    var resolver := CardEffectResolver.new()
    var context := {"enemies":[enemy],"target_position":Vector2.ZERO}
    var energy_before := energy.current
    var draw_before := deck.draw_index
    _check(runtime.play(0, energy, resolver, context), "Card #26 fixture must traverse CardRuntime generically", failures)
    _check(enemy.hp < enemy.max_hp, "Card #26 fixture must produce its declared runtime effect", failures)
    _check(energy.current < energy_before, "Card #26 must consume energy through the generic runtime", failures)
    _check(deck.draw_index > draw_before, "Card #26 play must advance the generic draw index", failures)

    var hero_definition := HeroDefinition.from_dict(hero_9)
    _check(hero_definition.id == hero_9.id, "Hero #9 must be consumable by HeroDefinition", failures)
    _check(hero_definition.mastery_id == hero_9.mastery_id, "Hero #9 mastery must remain data-driven", failures)

    var arena_definition := ArenaDefinition.from_dict(arena_16)
    _check(arena_definition.id == arena_16.id, "Arena #16 must be consumable by ArenaDefinition", failures)
    var director := ArenaDirector.new()
    director.configure(arena_16)
    _check(director.definition.get("id", "") == arena_16.id, "Arena #16 must be consumed by the generic ArenaDirector configuration", failures)
    director.tick(3.0)
    _check(director.is_cataclysm(), "Arena #16 must use the generic cataclysm contract", failures)
    _check(director.cataclysm_radius < 600.0, "Arena #16 cataclysm must mutate through generic ArenaDirector logic", failures)

    _check(ForgeWarDefinitions.is_valid_state(war.status), "additional ForgeWar must satisfy its state contract", failures)
    _check(war.participating_forges.has(forge.id), "additional ForgeWar must reference additional Forge data", failures)
    _check(war.war_arena_id == war_arena.id, "ForgeWar must reference WarArena data by id", failures)

    _assert_engine_has_no_fixture_branches(failures)

    if failures.is_empty():
        print("ARENA_FORGE_CONTENT_EXPANSION_SCALE_OK card=26 hero=9 arena=16 war_arena=2 forge=2 forge_war=100")
        quit()
        return
    for failure in failures:
        push_error("CONTENT EXPANSION SCALE FAILURE: " + failure)
    quit(1)

func _assert_engine_has_no_fixture_branches(failures: Array[String]) -> void:
    var engine_paths := [
        "res://scripts/cards/card_runtime.gd",
        "res://scripts/cards/card_effect_resolver.gd",
        "res://scripts/core/combat.gd",
        "res://scripts/core/arena_director.gd",
        "res://scripts/core/match_runtime.gd",
        "res://scripts/core/arena_state.gd",
        "res://scripts/data/forge_war_definitions.gd"
    ]
    var fixture_tokens := ["card_26_fixture", "hero_9_fixture", "arena_16_fixture", "forge_war_100_fixture", "forge_2_fixture", "war_arena_2_fixture"]
    for path in engine_paths:
        var file := FileAccess.open(path, FileAccess.READ)
        _check(file != null, "must be able to inspect engine source: " + path, failures)
        if file == null:
            continue
        var source := file.get_as_text()
        for token in fixture_tokens:
            _check(not source.contains(token), path + " must not contain fixture-specific branches", failures)

func _check(condition: bool, message: String, failures: Array[String]) -> void:
    if not condition:
        failures.append(message)
