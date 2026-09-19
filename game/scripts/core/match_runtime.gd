class_name MatchRuntime
extends RefCounted

signal phase_changed(previous: MatchState.Phase, current: MatchState.Phase)
signal event_requested(event: Dictionary)
signal event_resolved(event: Dictionary)
signal finished(rewards: Dictionary)
signal card_play_requested(index: int)
signal upgrade_selection_requested(index: int)

var state := MatchState.new()
var arena := ArenaState.new()
var director := ArenaDirector.new()
var telegraph := Telegraph.new()
var combat := CombatSystem.new()
var progression := MatchProgression.new()
var hero := ArenaHero.new()
var enemies: Array[ArenaEnemy] = []
var pending_event: Dictionary = {}
var kills := 0
var rewards: Dictionary = {}
var _last_phase := MatchState.Phase.CONTROL
var _event_count := 0

func configure(arena_definition: Dictionary, control_end := 90.0, cataclysm_start := 180.0, end_seconds := 240.0) -> void:
    state.configure(control_end, cataclysm_start, end_seconds)
    director.configure(arena_definition)
    arena = ArenaState.new()
    telegraph = Telegraph.new()
    hero = ArenaHero.new()
    hero.position = Vector2(640, 360)
    enemies.clear()
    pending_event.clear()
    kills = 0
    rewards.clear()
    _event_count = 0
    _last_phase = state.phase

func add_enemy(enemy: ArenaEnemy) -> void:
    enemies.append(enemy)

func submit_command(command: MatchCommand, delta: float) -> bool:
    if command == null or state.is_result() or delta < 0.0:
        return false
    match command.type:
        MatchCommand.Type.MOVE:
            if delta <= 0.0 or command.direction.length_squared() > 1.0001:
                return false
            hero.move(command.direction, delta)
            hero.position.x = clampf(hero.position.x, 70.0, 1210.0)
            hero.position.y = clampf(hero.position.y, 70.0, 650.0)
            return true
        MatchCommand.Type.PLAY_CARD:
            if command.index < 0:
                return false
            card_play_requested.emit(command.index)
            return true
        MatchCommand.Type.SELECT_UPGRADE:
            if command.index < 0:
                return false
            upgrade_selection_requested.emit(command.index)
            return true
        _:
            return false

func request_event() -> Dictionary:
    if not pending_event.is_empty() or telegraph.active:
        return {}
    pending_event = director.request_next_event()
    if pending_event.is_empty():
        return {}
    telegraph = Telegraph.new(str(pending_event.get("id", "event")), float(pending_event.get("warning_seconds", 1.5)))
    event_requested.emit(pending_event.duplicate(true))
    return pending_event.duplicate(true)

func tick(delta: float) -> void:
    if state.is_result():
        return
    var previous := state.phase
    state.tick(delta)
    if previous != state.phase:
        _last_phase = previous
        phase_changed.emit(previous, state.phase)
    director.tick(delta)
    arena.tick(delta)
    for enemy in enemies:
        enemy.tick(delta)
    if not pending_event.is_empty() and telegraph.tick(delta):
        _resolve_event()
    if state.phase == MatchState.Phase.CATACLYSM:
        _apply_cataclysm_pressure()
    if state.phase == MatchState.Phase.RESULT and rewards.is_empty():
        _finish()

func _resolve_event() -> void:
    var resolved := director.resolve_pending_event()
    _event_count += 1
    var point := Vector2i((_event_count * 3) % arena.width, (_event_count * 2) % arena.height)
    var mutation := str(resolved.get("mutation", ""))
    if mutation == "destroy_tile" or str(resolved.get("type", "")) == "destruction":
        arena.destroy_tile(point.x, point.y)
    else:
        arena.add_hazard(mutation if mutation != "" else "fire_hazard", 1.0, float(resolved.get("duration_seconds", 2.0)))
        arena.set_tile(point.x, point.y, ArenaState.Tile.FIRE)
    pending_event.clear()
    telegraph = Telegraph.new()
    event_resolved.emit(resolved.duplicate(true))

func _apply_cataclysm_pressure() -> void:
    if hero.dead:
        return
    for enemy in enemies:
        if enemy.dead:
            continue
        if not is_inside_cataclysm(hero.position):
            combat.resolve_hero_hit(hero, 1.0, Vector2.ZERO, 0.0)
            break

func is_inside_cataclysm(position: Vector2) -> bool:
    return position.distance_to(Vector2.ZERO) <= director.cataclysm_radius

func _finish() -> void:
    rewards = MatchRewards.calculate(state.elapsed, kills, progression.level, not hero.dead)
    progression.add_xp(int(rewards.get("xp", 0)))
    finished.emit(rewards.duplicate(true))

func deal_damage(enemy: ArenaEnemy, amount: float, direction := Vector2.ZERO, knockback := 0.0) -> bool:
    var killed := combat.resolve_hit(enemy, amount, direction, knockback)
    if killed:
        kills += 1
        progression.add_xp(10)
    return killed

func read_snapshot(presentation_energy: float, card_hand: Array, pending_upgrade: bool) -> MatchReadSnapshot:
    return MatchReadSnapshot.new(self, presentation_energy, card_hand, pending_upgrade)

func result() -> Dictionary:
    return rewards.duplicate(true)
