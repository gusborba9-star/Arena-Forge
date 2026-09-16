extends SceneTree

func _init() -> void:
    var scene := load("res://scenes/main.tscn") as PackedScene
    if scene == null:
        push_error("BOOTSTRAP FAILURE: main scene could not be loaded")
        quit(1)
        return
    var instance := scene.instantiate()
    if instance == null:
        push_error("BOOTSTRAP FAILURE: main scene could not be instantiated")
        quit(1)
        return
    root.add_child(instance)
    await process_frame
    print("ARENA_FORGE_BOOTSTRAP_SMOKE_OK main_scene=instantiated")
    instance.queue_free()
    quit(0)
