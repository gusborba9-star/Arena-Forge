class_name CardEffect
extends RefCounted
var kind := "damage"
var value := 0.0
var area := 120.0
var duration := 0.0
var target_type := "area"
func configure(data: Dictionary) -> void:
    kind = str(data.get("kind", kind))
    value = float(data.get("value", value))
    area = float(data.get("area", area))
    duration = float(data.get("duration", duration))
    target_type = str(data.get("target_type", target_type))
