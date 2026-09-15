class_name ArenaDirector
extends RefCounted
var definition: Dictionary = {}
var elapsed := 0.0
var event_timer := 0.0
var cataclysm_radius := 600.0
var pending_event: Dictionary = {}
func configure(value: Dictionary) -> void:
    definition = value.duplicate(true)
    elapsed = 0.0
    event_timer = 0.0
    pending_event.clear()
    cataclysm_radius = float(definition.get("cataclysm", {}).get("start_radius", 600.0))
func tick(delta: float) -> void:
    elapsed += delta
    event_timer = maxf(0.0, event_timer - delta)
    _update_cataclysm()
func request_next_event() -> Dictionary:
    if not pending_event.is_empty() or event_timer > 0.0: return {}
    var events: Array = definition.get("events", [])
    if events.is_empty(): return {}
    var event: Dictionary = events[int(floor(elapsed / 10.0)) % events.size()].duplicate(true)
    event["started_at"] = elapsed
    pending_event = event
    return event.duplicate(true)
func resolve_pending_event() -> Dictionary:
    if pending_event.is_empty(): return {}
    var result := pending_event.duplicate(true)
    event_timer = float(result.get("cooldown_seconds", 18.0))
    pending_event.clear()
    return result
func is_cataclysm() -> bool:
    return elapsed >= float(definition.get("cataclysm", {}).get("starts_at", 180.0))
func _update_cataclysm() -> void:
    var c: Dictionary = definition.get("cataclysm", {})
    var start := float(c.get("starts_at", 180.0))
    var duration := maxf(1.0, float(c.get("duration", 60.0)))
    var progress := clampf((elapsed - start) / duration, 0.0, 1.0)
    cataclysm_radius = lerpf(float(c.get("start_radius", 600.0)), float(c.get("end_radius", 120.0)), progress)
