extends SceneTree
const RunnerExit = preload("res://tests/support/runner_exit.gd")

func _init() -> void:
    RunnerExit.failure(self, ["ARENA_FORGE_RUNNER_EXIT_EXPECTED_FAILURE"])
