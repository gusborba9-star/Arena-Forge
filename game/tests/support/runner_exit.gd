extends RefCounted

## Single exit contract for all Arena Forge Godot contract runners.
## Godot 4.4 documents SceneTree.quit(exit_code) as the process exit-status API.
## The quit request is deferred so runner finalization occurs after the current
## initialization/stack unwinds and uses exactly one authoritative exit request.

static func success(tree: SceneTree, marker: String) -> void:
    print(marker)
    tree.quit.call_deferred(0)

static func failure(tree: SceneTree, failures: Array[String]) -> void:
    for failure in failures:
        push_error(failure)
    tree.quit.call_deferred(1)
