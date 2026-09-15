class_name MobileInput
extends RefCounted
var touch_active := false
var origin := Vector2.ZERO
var current := Vector2.ZERO
func begin_touch(p: Vector2) -> void: touch_active=true; origin=p; current=p
func update_touch(p: Vector2) -> void: current=p
func end_touch() -> void: touch_active=false; current=origin
func get_move_vector() -> Vector2:
    if not touch_active: return Vector2.ZERO
    return (current-origin).limit_length(90.0) / 90.0
