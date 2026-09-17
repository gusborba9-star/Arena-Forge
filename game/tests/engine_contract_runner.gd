extends SceneTree
const RunnerExit = preload("res://tests/support/runner_exit.gd")

func _init() -> void:
    var failures: Array[String] = []
    var validation := ContentValidation.validate()
    _check(validation.valid, "content validation", failures)
    _check(validation.heroes == 4, "hero count", failures)
    _check(validation.cards == 16, "card count", failures)
    _check(validation.arenas == 15, "arena count", failures)

    var energy := EnergyPool.new()
    energy.configure(10.0, 1.5)
    _check(energy.can_spend(4.0), "energy can spend", failures)
    _check(energy.spend(4.0), "energy spend", failures)
    _check(is_equal_approx(energy.current, 6.0), "energy current after spend", failures)
    _check(not energy.can_spend(7.0), "energy overspend guard", failures)
    energy.tick(1.5)
    _check(is_equal_approx(energy.current, 7.0), "energy regeneration", failures)

    var arena := ArenaState.new()
    arena.add_hazard("test", 1.0, 1.0)
    _check(arena.active_hazards.size() == 1, "hazard active", failures)
    arena.tick(0.5)
    _check(arena.active_hazards.size() == 1, "hazard remains active", failures)
    arena.tick(0.5)
    _check(arena.active_hazards.is_empty(), "hazard expires", failures)
    _check(arena.destroy_tile(0, 0) == ArenaState.Tile.CRACKED, "tile cracked", failures)
    _check(arena.destroy_tile(0, 0) == ArenaState.Tile.COLLAPSED, "tile collapsed", failures)
    _check(arena.destroy_tile(0, 0) == ArenaState.Tile.ABYSS, "tile abyss", failures)

    var rules := ArenaRules.resolve_element_interaction("water", "electricity")
    _check(rules.reaction == "shock_zone", "element interaction", failures)

    var enemy := ArenaEnemy.new()
    enemy.configure(ArenaEnemy.Role.CHASER, 100.0, 10.0, 100.0, 0.0)
    enemy.position = Vector2(100, 0)
    enemy.apply_slow(0.5, 2.0)
    enemy.move_toward_target(Vector2(200, 0), 1.0)
    _check(is_equal_approx(enemy.position.x, 150.0), "enemy movement", failures)
    enemy.tick(2.0)
    _check(is_equal_approx(enemy.slow_multiplier, 1.0), "enemy slow expiry", failures)

    var state := MatchState.new()
    state.configure(90.0, 180.0, 240.0)
    state.tick(181.0)
    _check(state.phase == MatchState.Phase.CATACLYSM, "match cataclysm phase", failures)
    state.tick(59.0)
    _check(state.is_result(), "match result phase", failures)

    var hero := ArenaHero.new()
    hero.configure(HeroDefinitions.initial()[0])
    var build := BuildState.new()
    var upgrade := UpgradeOffer.new("test", "common", {"damage": 4.0, "max_hp": 10.0})
    _check(build.apply_upgrade(upgrade), "upgrade apply", failures)
    build.apply_to_hero(hero)
    _check(is_equal_approx(hero.damage, hero.base_damage + 4.0), "hero damage upgrade", failures)
    _check(is_equal_approx(hero.max_hp, hero.base_hp + 10.0), "hero hp upgrade", failures)

    if failures.is_empty():
        RunnerExit.success(self, "ARENA_FORGE_ENGINE_CONTRACTS_OK")
    else:
        RunnerExit.failure(self, failures)

func _check(condition: bool, message: String, failures: Array[String]) -> void:
    if not condition:
        failures.append(message + " | expected=true | found=false")
