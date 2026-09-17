extends SceneTree
const RunnerExit = preload("res://tests/support/runner_exit.gd")

func _init() -> void:
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
    instance.queue_free()
    RunnerExit.success(self, "ARENA_FORGE_BOOTSTRAP_SMOKE_OK main_scene=instantiated")
