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

func _check(condition: bool, message: String, failures: Array[String]) -> void:
    if not condition:
        failures.append(message)
