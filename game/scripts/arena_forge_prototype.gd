extends Node2D

var hero := ArenaHero.new()
var energy := EnergyPool.new()
var arena := ArenaState.new()
var combat := CombatSystem.new()
var match_state := MatchState.new()
var progression := MatchProgression.new()
var deck := ArenaDeck.new()
var runtime := CardRuntime.new()
var resolver := CardEffectResolver.new()
var catalog := ContentCatalog.new()
var input := MobileInput.new()
var director := ArenaDirector.new()
var telegraph := Telegraph.new()
var build := BuildState.new()
var enemies: Array[ArenaEnemy] = []
var upgrades: Array[UpgradeOffer] = []
var upgrade_pool: Array[Dictionary] = []
var pending_event: Dictionary = {}
var pending_upgrade := false
var attack_timer := 0.0
var enemy_timer := 0.0
var cataclysm_timer := 0.0
var speed_left := 0.0
var speed_multiplier := 1.0
var base_speed := 260.0
var kills := 0
var event_count := 0
var rewards := {}
var runtime_config: Dictionary = {}
var match_runtime: MatchRuntime = null

func _ready() -> void:
    runtime_config = _load_runtime_config()
    match_runtime = MatchRuntime.new()
    var match_config: Dictionary = runtime_config.get("match", {})
    energy.configure(float(match_config.get("max_energy", 10.0)), float(match_config.get("energy_regen_interval", 1.5)))
    for h in HeroDefinitions.initial(): catalog.register_hero(h)
    for c in CardDefinitions.initial(): catalog.register_card(c)
    for a in ArenaDefinitions.initial(): catalog.register_arena(a)
    upgrade_pool = UpgradeDefinitions.initial()
    var arena_definition := ArenaRuntimeDefinitions.arena_1()
    arena_definition["cataclysm"] = _cataclysm_config()
    match_runtime.configure(
        arena_definition,
        float(match_config.get("control_end_seconds", 90.0)),
        float(match_config.get("cataclysm_start_seconds", 180.0)),
        float(match_config.get("end_seconds", 240.0))
    )
    match_runtime.card_play_requested.connect(_play_card)
    match_runtime.upgrade_selection_requested.connect(_select_upgrade)
    match_state = match_runtime.state
    hero = match_runtime.hero
    arena = match_runtime.arena
    director = match_runtime.director
    telegraph = match_runtime.telegraph
    combat = match_runtime.combat
    progression = match_runtime.progression
    enemies = match_runtime.enemies
    hero.configure(HeroDefinitions.initial()[2])
    base_speed = hero.speed
    var cards: Array[ArenaCard] = []
    var deck_size := int(runtime_config.get("deck", {}).get("size", 8))
    var definitions := CardDefinitions.initial()
    for i in range(mini(deck_size, definitions.size())): cards.append(ArenaCard.from_definition(definitions[i]))
    deck.set_deck(cards)
    runtime.configure(deck)
    _spawn_wave()
    queue_redraw()

func _load_runtime_config() -> Dictionary:
    var file := FileAccess.open("res://config/arena-forge-config.json", FileAccess.READ)
    if file == null:
        push_error("Arena Forge runtime config could not be opened")
        return {}
    var parsed = JSON.parse_string(file.get_as_text())
    if typeof(parsed) != TYPE_DICTIONARY:
        push_error("Arena Forge runtime config is invalid")
        return {}
    return parsed

func _cataclysm_config() -> Dictionary:
    var config: Dictionary = runtime_config.get("arena", {})
    var match_config: Dictionary = runtime_config.get("match", {})
    return {
        "starts_at": float(match_config.get("cataclysm_start_seconds", 180.0)),
        "duration": maxf(1.0, float(match_config.get("end_seconds", 240.0)) - float(match_config.get("cataclysm_start_seconds", 180.0))),
        "start_radius": float(config.get("cataclysm_start_radius", 600.0)),
        "end_radius": float(config.get("cataclysm_end_radius", 120.0))
    }

func _input(event: InputEvent) -> void:
    if event is InputEventScreenTouch:
        if event.pressed and event.position.x < 500: input.begin_touch(event.position)
        elif event.pressed: match_runtime.submit_command(MatchCommand.play_card(int((event.position.x - 560) / 170.0)), 0.0)
        else: input.end_touch()
    elif event is InputEventScreenDrag and input.touch_active: input.update_touch(event.position)
    elif event is InputEventKey and event.pressed:
        if pending_upgrade and event.keycode >= KEY_1 and event.keycode <= KEY_3: match_runtime.submit_command(MatchCommand.select_upgrade(event.keycode - KEY_1), 0.0)
        elif event.keycode >= KEY_1 and event.keycode <= KEY_4: match_runtime.submit_command(MatchCommand.play_card(event.keycode - KEY_1), 0.0)

func _process(delta: float) -> void:
    if hero.dead or match_state.is_result():
        if match_state.is_result() and rewards.is_empty(): rewards = MatchRewards.calculate(match_state.elapsed, kills, progression.level, not hero.dead)
        queue_redraw(); return
    match_state.tick(delta); energy.tick(delta); runtime.tick(delta); director.tick(delta); arena.tick(delta)
    attack_timer = maxf(0.0, attack_timer - delta); enemy_timer = maxf(0.0, enemy_timer - delta); cataclysm_timer = maxf(0.0, cataclysm_timer - delta)
    _tick_event(delta); _tick_speed(delta); _move_hero(delta); _move_enemies(delta)
    if attack_timer <= 0.0: _auto_attack(); attack_timer = float(runtime_config.get("match", {}).get("auto_attack_interval", 0.55))
    if enemy_timer <= 0.0: _enemy_attack(); enemy_timer = float(runtime_config.get("match", {}).get("enemy_attack_interval", 1.2))
    if progression.level > 1 and upgrades.is_empty() and not pending_upgrade: _make_upgrades()
    if director.is_cataclysm() and cataclysm_timer <= 0.0: _cataclysm_damage(); cataclysm_timer = 1.0
    queue_redraw()

func _tick_event(delta: float) -> void:
    if pending_event.is_empty() and not telegraph.active:
        pending_event = director.request_next_event()
        if not pending_event.is_empty(): telegraph = Telegraph.new(str(pending_event.id), float(pending_event.get("warning_seconds", runtime_config.get("telegraph", {}).get("default_warning_seconds", 1.5))))
    if not pending_event.is_empty() and telegraph.tick(delta):
        var resolved := director.resolve_pending_event(); event_count += 1
        var p := Vector2i((event_count * 3) % arena.width, (event_count * 2) % arena.height)
        if str(resolved.get("type")) == "destruction": arena.destroy_tile(p.x, p.y)
        else: arena.set_tile(p.x, p.y, ArenaState.Tile.FIRE)
        pending_event.clear(); telegraph = Telegraph.new()

func _tick_speed(delta: float) -> void:
    if speed_left <= 0.0: hero.speed = base_speed; speed_multiplier = 1.0; return
    speed_left = maxf(0.0, speed_left - delta)
    if speed_left <= 0.0: hero.speed = base_speed; speed_multiplier = 1.0

func _move_hero(delta: float) -> void:
    var command := input.get_move_command()
    if command.direction == Vector2.ZERO:
        command = MatchCommand.move(Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down"))
    match_runtime.submit_command(command, delta)

func _move_enemies(delta: float) -> void:
    for e in enemies:
        if e.dead: continue
        e.tick(delta)
        var target := hero.position
        if e.role == ArenaEnemy.Role.RANGED and e.position.distance_to(hero.position) < 260: target = hero.position + (e.position - hero.position).normalized() * 260
        e.move_toward_target(target, delta)

func _nearest(max_distance: float) -> ArenaEnemy:
    var result: ArenaEnemy = null; var best := max_distance
    for e in enemies:
        if e.dead: continue
        var d := hero.position.distance_to(e.position)
        if d <= best: best = d; result = e
    return result

func _auto_attack() -> void:
    var target := _nearest(360)
    if target and combat.resolve_hit(target, hero.damage, target.position - hero.position, 90): kills += 1; progression.add_xp(10)

func _enemy_attack() -> void:
    for e in enemies:
        if e.dead: continue
        var r := 280.0 if e.role == ArenaEnemy.Role.RANGED else float(runtime_config.get("match", {}).get("enemy_contact_range", 42.0))
        if e.position.distance_to(hero.position) <= r:
            combat.resolve_hero_hit(hero, e.damage, e.position - hero.position, 40)
            break

func _play_card(index: int) -> void:
    if pending_upgrade or index < 0 or index >= deck.hand.size(): return
    var context = {"hero": hero, "enemies": enemies, "arena": arena, "target_position": hero.position}
    if runtime.play(index, energy, resolver, context):
        if context.has("hero_speed_multiplier"): speed_multiplier = float(context.hero_speed_multiplier); speed_left = float(context.hero_speed_duration); hero.speed = base_speed * speed_multiplier
        if context.has("spawn_request"): _spawn_units(str(context.spawn_request.kind), int(context.spawn_request.count))

func _spawn_units(kind: String, count: int) -> void:
    for i in range(count):
        var e := ArenaEnemy.new()
        if kind == "brute": e.configure(ArenaEnemy.Role.TANK, 110, 14, 54, 3)
        else: e.configure(ArenaEnemy.Role.SWARM, 18, 4, 108, 0)
        e.position = hero.position + Vector2(35 + i * 20, 0); enemies.append(e)

func _spawn_wave() -> void:
    var roles = [ArenaEnemy.Role.CHASER, ArenaEnemy.Role.RANGED, ArenaEnemy.Role.TANK, ArenaEnemy.Role.SWARM, ArenaEnemy.Role.ELITE]
    var hp = [40, 32, 95, 22, 140]; var dmg = [8, 6, 12, 4, 18]; var sp = [90, 76, 50, 120, 72]; var ar = [0.5, 0, 2, 0, 5]
    for i in range(5):
        var e := ArenaEnemy.new(); e.configure(roles[i], hp[i], dmg[i], sp[i], ar[i]); e.position = Vector2(180 + i * 230, 120 if i % 2 == 0 else 600); enemies.append(e)
    match_runtime.enemies = enemies

func _make_upgrades() -> void:
    upgrades.clear()
    if upgrade_pool.is_empty(): return
    for i in range(3):
        var d := upgrade_pool[(progression.level + i) % upgrade_pool.size()]; upgrades.append(UpgradeOffer.new(d.id, d.rarity, d.effects))
    pending_upgrade = not upgrades.is_empty()

func _select_upgrade(index: int) -> void:
    if not pending_upgrade or index < 0 or index >= upgrades.size(): return
    build.apply_upgrade(upgrades[index]); build.apply_to_hero(hero); pending_upgrade = false; upgrades.clear()

func _cataclysm_damage() -> void:
    var radius := director.cataclysm_radius; var center := Vector2(640, 360)
    if hero.position.distance_to(center) > radius: combat.resolve_hero_hit(hero, 10, center - hero.position, 0)
    for e in enemies:
        if not e.dead and e.position.distance_to(center) > radius:
            if e.take_damage(10): kills += 1

func _draw() -> void:
    draw_rect(Rect2(40, 40, 1200, 640), Color("10131a"), true)
    draw_circle(hero.position, 24, Color("40c8ff"))
    for e in enemies:
        if not e.dead: draw_circle(e.position, 17, Color("ff5c4d"))
    draw_string(ThemeDB.fallback_font, Vector2(60, 72), "ARENA FORGE", HORIZONTAL_ALIGNMENT_LEFT, -1, 26)
    draw_string(ThemeDB.fallback_font, Vector2(60, 105), "%s  |  %.1fs  |  HP %.0f  |  Energy %.0f  |  LV %d  |  Kills %d" % [MatchState.Phase.keys()[match_state.phase], match_state.elapsed, hero.hp, energy.current, progression.level, kills], HORIZONTAL_ALIGNMENT_LEFT, -1, 18)
    if telegraph.active: draw_string(ThemeDB.fallback_font, Vector2(60, 140), "TELEGRAPH: %s  %.1fs" % [telegraph.id, telegraph.remaining], HORIZONTAL_ALIGNMENT_LEFT, -1, 20)
    for i in range(deck.hand.size()): draw_string(ThemeDB.fallback_font, Vector2(560 + i * 170, 650), "%d %s (%dE)" % [i + 1, deck.hand[i].card_name, deck.hand[i].energy_cost], HORIZONTAL_ALIGNMENT_LEFT, 160, 16)
    if pending_upgrade: draw_string(ThemeDB.fallback_font, Vector2(420, 200), "ESCOLHA UMA MELHORIA: 1  2  3", HORIZONTAL_ALIGNMENT_LEFT, -1, 26)
