extends SceneTree

func _init() -> void:
    var failures: Array[String] = []
    _run_lifecycle(failures)
    _run_event_lifecycle(failures)
    _run_cataclysm(failures)
    _run_enemy_roles(failures)
    _run_combat_xp_rewards(failures)
    if failures.is_empty():
        print("ARENA_FORGE_A1_RUNTIME_OK lifecycle=4 phases events=2 cataclysm=progressive roles=5 combat=xp rewards=result")
        quit(0)
    else:
        for failure in failures:
            push_error("A1 FAILURE: " + failure)
        quit(1)

func _check(condition: bool, message: String, failures: Array[String]) -> void:
    if not condition:
        failures.append(message)

func _arena_one() -> Dictionary:
    var definition := ArenaRuntimeDefinitions.arena_1()
    definition["cataclysm"] = {"starts_at": 2.0, "duration": 1.0, "start_radius": 100.0, "end_radius": 20.0}
    return definition

func _run_lifecycle(failures: Array[String]) -> void:
    var runtime := MatchRuntime.new()
    runtime.configure(_arena_one(), 1.0, 2.0, 3.0)
    _check(runtime.state.phase == MatchState.Phase.CONTROL, "initial phase must be CONTROL", failures)
    runtime.tick(1.0)
    _check(runtime.state.phase == MatchState.Phase.IGNITION, "CONTROL must transition to IGNITION", failures)
    runtime.tick(1.0)
    _check(runtime.state.phase == MatchState.Phase.CATACLYSM, "IGNITION must transition to CATACLYSM", failures)
    runtime.tick(1.0)
    _check(runtime.state.phase == MatchState.Phase.RESULT, "CATACLYSM must transition to RESULT", failures)

func _run_event_lifecycle(failures: Array[String]) -> void:
    var runtime := MatchRuntime.new()
    runtime.configure(_arena_one(), 10.0, 20.0, 30.0)
    var requested := runtime.request_event()
    _check(not requested.is_empty(), "event request must return an event", failures)
    _check(runtime.telegraph.active, "event request must activate telegraph", failures)
    var warning := float(requested.get("warning_seconds", 1.5))
    runtime.tick(maxf(0.0, warning - 0.1))
    _check(runtime.telegraph.active, "event must not resolve before warning ends", failures)
    var before_tile := runtime.arena.get_tile(0, 0)
    runtime.tick(0.1)
    _check(not runtime.telegraph.active, "telegraph must end after warning", failures)
    _check(runtime.pending_event.is_empty(), "pending event must clear after resolve", failures)
    _check(runtime.arena.active_hazards.size() > 0 or runtime.arena.get_tile(0, 0) != before_tile, "event resolution must mutate arena state", failures)

    var destruction := {"id":"ground_break","type":"destruction","warning_seconds":0.5,"cooldown_seconds":1.0}
    var custom := {"id":"arena_1_test","events":[destruction],"cataclysm":{"starts_at":20.0,"duration":10.0,"start_radius":100.0,"end_radius":20.0}}
    runtime.configure(custom, 10.0, 20.0, 30.0)
    runtime.request_event()
    runtime.tick(0.5)
    _check(runtime.arena.get_tile(3, 2) == ArenaState.Tile.CRACKED, "destruction event must execute tile mutation", failures)

func _run_cataclysm(failures: Array[String]) -> void:
    var runtime := MatchRuntime.new()
    runtime.configure(_arena_one(), 1.0, 2.0, 4.0)
    runtime.tick(2.0)
    var start_radius := runtime.director.cataclysm_radius
    runtime.tick(0.5)
    var intermediate_radius := runtime.director.cataclysm_radius
    runtime.tick(0.5)
    var end_radius := runtime.director.cataclysm_radius
    _check(start_radius > intermediate_radius, "cataclysm radius must shrink after start", failures)
    _check(intermediate_radius > end_radius, "cataclysm radius must continue shrinking", failures)
    runtime.hero.position = Vector2(0.0, 0.0)
    _check(runtime.is_inside_cataclysm(runtime.hero.position), "entity inside radius must be inside", failures)
    runtime.hero.position = Vector2(1000.0, 0.0)
    _check(not runtime.is_inside_cataclysm(runtime.hero.position), "entity outside radius must be outside", failures)

func _run_enemy_roles(failures: Array[String]) -> void:
    var positions: Dictionary = {}
    for role in [ArenaEnemy.Role.CHASER, ArenaEnemy.Role.RANGED, ArenaEnemy.Role.TANK, ArenaEnemy.Role.SWARM, ArenaEnemy.Role.ELITE]:
        var enemy := ArenaEnemy.new()
        enemy.configure(role, 100.0, 10.0, 100.0, 0.0)
        enemy.position = Vector2(500.0, 0.0)
        enemy.move_toward_target(Vector2.ZERO, 1.0)
        positions[role] = enemy.position.x
    _check(positions[ArenaEnemy.Role.SWARM] < positions[ArenaEnemy.Role.CHASER], "SWARM must move faster than CHASER", failures)
    _check(positions[ArenaEnemy.Role.TANK] > positions[ArenaEnemy.Role.CHASER], "TANK must move slower than CHASER", failures)
    _check(positions[ArenaEnemy.Role.ELITE] < positions[ArenaEnemy.Role.CHASER], "ELITE must move faster than CHASER", failures)
    var ranged := ArenaEnemy.new()
    ranged.configure(ArenaEnemy.Role.RANGED, 100.0, 10.0, 100.0, 0.0)
    ranged.position = Vector2(170.0, 0.0)
    ranged.move_toward_target(Vector2.ZERO, 1.0)
    _check(is_equal_approx(ranged.position.x, 170.0), "RANGED must preserve its preferred distance", failures)

func _run_combat_xp_rewards(failures: Array[String]) -> void:
    var runtime := MatchRuntime.new()
    runtime.configure(_arena_one(), 1.0, 2.0, 3.0)
    var enemy := ArenaEnemy.new()
    enemy.configure(ArenaEnemy.Role.CHASER, 20.0, 10.0, 100.0, 2.0)
    enemy.position = Vector2(10.0, 0.0)
    var hp_before := enemy.hp
    runtime.deal_damage(enemy, 10.0, Vector2.RIGHT, 5.0)
    _check(enemy.hp < hp_before, "combat must apply damage after armor", failures)
    _check(is_equal_approx(enemy.position.x, 15.0), "combat must apply knockback", failures)
    var killed := runtime.deal_damage(enemy, 20.0)
    _check(killed and enemy.dead, "combat must support death", failures)
    _check(runtime.kills == 1, "kill counter must increment", failures)
    _check(runtime.progression.xp > 0, "kill must grant XP", failures)
    runtime.tick(1.0)
    runtime.tick(1.0)
    runtime.tick(1.0)
    var result := runtime.result()
    _check(runtime.state.phase == MatchState.Phase.RESULT, "match must reach RESULT", failures)
    _check(not result.is_empty(), "RESULT must contain rewards", failures)
    _check(int(result.get("gold", 0)) > 0, "rewards must contain deterministic gold", failures)
    _check(int(result.get("xp", 0)) > 0, "rewards must contain deterministic XP", failures)
