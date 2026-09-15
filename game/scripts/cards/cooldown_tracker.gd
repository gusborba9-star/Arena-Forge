class_name CooldownTracker
extends RefCounted
var remaining := {}
func tick(delta: float) -> void:
    for id in remaining.keys(): remaining[id] = maxf(0.0, float(remaining[id]) - delta)
func ready(id: String) -> bool: return float(remaining.get(id, 0.0)) <= 0.0
func start(id: String, seconds: float) -> void:
    if seconds > 0.0: remaining[id] = seconds
