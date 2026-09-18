extends SceneTree
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

    var before := instance.match_runtime.hero.position
    _check(not instance.match_runtime.submit_command(MatchCommand.invalid(), 0.1), "invalid command must be rejected", failures)
    _check(instance.match_runtime.hero.position == before, "rejected command must not mutate runtime state", failures)

    _check(instance.match_runtime.submit_command(move_command, 0.1), "valid command must be accepted by Runtime", failures)
    _check(instance.match_runtime.hero.position != before, "accepted command must mutate runtime-owned state", failures)

    var after_valid := instance.match_runtime.hero.position
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

func _check(condition: bool, message: String, failures: Array[String]) -> void:
    if not condition:
        failures.append(message)
