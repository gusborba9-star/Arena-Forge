extends SceneTree

var received_card_command := -1
var received_upgrade_command := -1
const RunnerExit = preload("res://tests/support/runner_exit.gd")

func _init() -> void:
    var failures: Array[String] = []
    var scene := load("res://scenes/main.tscn") as PackedScene
    if scene == null:
        RunnerExit.failure(self, ["BOOTSTRAP FAILURE: main scene could not be loaded"])
        return
    var instance := scene.instantiate()
    if instance == null:
        RunnerExit.failure(self, ["BOOTSTRAP FAILURE: main scene could not be instantiated"])
        return
    root.add_child(instance)
    await process_frame

    _check(instance.match_runtime != null, "executable flow must own a MatchRuntime", failures)
    _check(instance.match_runtime.state == instance.match_state, "prototype state must reference MatchRuntime state", failures)
    _check(instance.match_runtime.hero == instance.hero, "prototype hero must reference MatchRuntime hero", failures)
    _check(instance.match_runtime.arena == instance.arena, "prototype arena must reference MatchRuntime arena", failures)
    _check(instance.match_runtime.director == instance.director, "prototype director must reference MatchRuntime director", failures)
    _check(instance.match_runtime.combat == instance.combat, "prototype combat must reference MatchRuntime combat", failures)
    _check(instance.match_runtime.progression == instance.progression, "prototype progression must reference MatchRuntime progression", failures)
    _check(instance.match_runtime.enemies == instance.enemies, "prototype enemies must reference MatchRuntime enemies", failures)
    _check(not instance.match_runtime.director.definition.is_empty(), "MatchRuntime must be configured with an arena definition", failures)
    _check(instance.match_runtime.state.control_end == 90.0, "MatchRuntime control timing must be configured", failures)
    _check(instance.match_runtime.state.cataclysm_start == 180.0, "MatchRuntime cataclysm timing must be configured", failures)
    _check(instance.match_runtime.state.end_seconds == 240.0, "MatchRuntime result timing must be configured", failures)
    _check(instance.match_runtime.arena.width == 12 and instance.match_runtime.arena.height == 7, "MatchRuntime arena state must be initialized", failures)

    _run_command_boundary_contract(instance, failures)
    _run_mutation_rules_contract(instance, failures)
    _run_extended_command_boundary_contract(instance, failures)

    var prototype_source := FileAccess.open("res://scripts/arena_forge_prototype.gd", FileAccess.READ)
    if prototype_source == null:
        failures.append("prototype source must be readable for ownership guard")
    else:
        var source_text := prototype_source.get_as_text()
        var runtime_constructor_count := source_text.split("MatchRuntime.new()").size() - 1
        _check(runtime_constructor_count == 1, "prototype must create exactly one MatchRuntime", failures)

    instance.queue_free()
    if failures.is_empty():
        RunnerExit.success(self, "ARENA_FORGE_BOOTSTRAP_SMOKE_OK main_scene=instantiated runtime=owned")
    else:
        for i in failures.size():
            failures[i] = "BOOTSTRAP FAILURE: " + failures[i]
        RunnerExit.failure(self, failures)

func _run_command_boundary_contract(instance, failures: Array[String]) -> void:
    var command_input := MobileInput.new()
    command_input.begin_touch(Vector2.ZERO)
    command_input.update_touch(Vector2(45.0, 0.0))
    var move_command := command_input.get_move_command()
    _check(move_command.type == MatchCommand.Type.MOVE, "input must create MOVE command", failures)

    var before: Vector2 = instance.match_runtime.hero.position
    _check(not instance.match_runtime.submit_command(MatchCommand.invalid(), 0.1), "invalid command must be rejected", failures)
    _check(instance.match_runtime.hero.position == before, "rejected command must not mutate runtime state", failures)

    _check(instance.match_runtime.submit_command(move_command, 0.1), "valid command must be accepted by Runtime", failures)
    _check(instance.match_runtime.hero.position != before, "accepted command must mutate runtime-owned state", failures)

    var after_valid: Vector2 = instance.match_runtime.hero.position
    var invalid_direction := MatchCommand.move(Vector2(2.0, 0.0))
    _check(not instance.match_runtime.submit_command(invalid_direction, 0.1), "out-of-range command must be rejected", failures)
    _check(instance.match_runtime.hero.position == after_valid, "rejected direction must not mutate runtime state", failures)

    var prototype_source := FileAccess.open("res://scripts/arena_forge_prototype.gd", FileAccess.READ)
    if prototype_source == null:
        failures.append("prototype source must be readable for command-boundary guard")
        return
    var source_text := prototype_source.get_as_text()
    _check(source_text.contains("match_runtime.submit_command(command, delta)"), "prototype must submit movement through MatchRuntime", failures)
    _check(not source_text.contains("hero.move("), "prototype must not mutate hero movement directly", failures)
    _check(not source_text.contains("hero.position.x = clampf"), "prototype must not clamp runtime hero state directly", failures)
    _check(not source_text.contains("hero.position.y = clampf"), "prototype must not clamp runtime hero state directly", failures)

    print("ARENA_FORGE_A2_2_COMMAND_BOUNDARY_OK input=command runtime=authority invalid=rejected state=runtime-owned")

func _run_extended_command_boundary_contract(instance, failures: Array[String]) -> void:
    received_card_command = -1
    received_upgrade_command = -1
    instance.match_runtime.card_play_requested.connect(_on_card_command)
    instance.match_runtime.upgrade_selection_requested.connect(_on_upgrade_command)

    _check(instance.match_runtime.submit_command(MatchCommand.play_card(999), 0.0), "PLAY_CARD command must be accepted by Runtime", failures)
    _check(received_card_command == 999, "Runtime must consume PLAY_CARD intent and emit authorized request", failures)

    _check(not instance.match_runtime.submit_command(MatchCommand.play_card(-1), 0.0), "invalid PLAY_CARD command must be rejected", failures)
    _check(received_card_command == 999, "rejected PLAY_CARD command must not emit a request", failures)

    _check(instance.match_runtime.submit_command(MatchCommand.select_upgrade(999), 0.0), "SELECT_UPGRADE command must be accepted by Runtime", failures)
    _check(received_upgrade_command == 999, "Runtime must consume SELECT_UPGRADE intent and emit authorized request", failures)

    _check(not instance.match_runtime.submit_command(MatchCommand.select_upgrade(-1), 0.0), "invalid SELECT_UPGRADE command must be rejected", failures)
    _check(received_upgrade_command == 999, "rejected SELECT_UPGRADE command must not emit a request", failures)

    var prototype_source := FileAccess.open("res://scripts/arena_forge_prototype.gd", FileAccess.READ)
    if prototype_source == null:
        failures.append("prototype source must be readable for extended command-boundary guard")
        return
    var source_text := prototype_source.get_as_text()
    _check(source_text.contains("MatchCommand.play_card("), "prototype input must create PLAY_CARD commands", failures)
    _check(source_text.contains("MatchCommand.select_upgrade("), "prototype input must create SELECT_UPGRADE commands", failures)
    _check(source_text.contains("match_runtime.card_play_requested.connect(_play_card)"), "legacy card execution must be downstream of Runtime command consumption", failures)
    _check(source_text.contains("match_runtime.upgrade_selection_requested.connect(_select_upgrade)"), "legacy upgrade execution must be downstream of Runtime command consumption", failures)
    _check(not source_text.contains(": _play_card("), "input must not bypass Runtime with direct card execution", failures)
    _check(not source_text.contains(": _select_upgrade("), "input must not bypass Runtime with direct upgrade execution", failures)

    print("ARENA_FORGE_A2_4_COMMAND_BOUNDARY_OK commands=move,play_card,select_upgrade runtime=consumer invalid=rejected")

func _on_card_command(index: int) -> void:
    received_card_command = index

func _on_upgrade_command(index: int) -> void:
    received_upgrade_command = index

func _run_mutation_rules_contract(instance, failures: Array[String]) -> void:
    var prototype_source := FileAccess.open("res://scripts/arena_forge_prototype.gd", FileAccess.READ)
    if prototype_source == null:
        failures.append("prototype source must be readable for mutation-rules guard")
        return

    var source_text := prototype_source.get_as_text()
    var forbidden_patterns := [
        "hero.move(",
        "hero.position =",
        "hero.position +=",
        "hero.position -=",
        "hero.position.x =",
        "hero.position.y =",
        "hero.set_position("
    ]
    var before_failures := failures.size()
    for pattern in forbidden_patterns:
        _check(not source_text.contains(pattern), "prototype must not bypass Runtime mutation authority with '%s'" % pattern, failures)

    _check(instance.match_runtime.hero == instance.hero, "Runtime must remain the owner of the executable hero", failures)
    _check(instance.match_runtime != null, "executable flow must expose exactly one MatchRuntime owner", failures)

    if failures.size() == before_failures:
        print("ARENA_FORGE_A2_3_MUTATION_RULES_OK authority=runtime bypass=blocked movement=command-only")

func _check(condition: bool, message: String, failures: Array[String]) -> void:
    if not condition:
        failures.append(message)
