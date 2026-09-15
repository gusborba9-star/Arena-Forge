class_name Telegraph
extends RefCounted
var id := "idle"
var remaining := 0.0
var active := false
func _init(event_id: String = "idle", duration: float = 0.0) -> void:
    id = event_id
    remaining = maxf(0.0, duration)
    active = duration > 0.0
func tick(delta: float) -> bool:
    if not active: return false
    remaining = maxf(0.0, remaining - delta)
    if remaining <= 0.0:
        active = false
        return true
    return false
