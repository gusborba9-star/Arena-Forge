extends SceneTree
const RunnerExit = preload("res://tests/support/runner_exit.gd")

func _init() -> void:
    RunnerExit.success(self, "ARENA_FORGE_RUNNER_EXIT_PASS_OK")
