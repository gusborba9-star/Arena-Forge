class_name ArenaEnemy
extends RefCounted

enum Role { CHASER, RANGED, TANK, SWARM, ELITE }

var role := Role.CHASER
var hp := 40.0
var max_hp := 40.0
var damage := 8.0
var speed := 90.0
var armor := 0.0
var slow_multiplier := 1.0
var slow_remaining := 0.0
var dead := false
var position := Vector2.ZERO

func configure(new_role: Role, new_hp: float, new_damage: float, new_speed: float, new_armor: float) -> void:
    role = new_role
    max_hp = maxf(0.0, new_hp)
    hp = max_hp
    damage = maxf(0.0, new_damage)
    speed = maxf(0.0, new_speed)
    armor = maxf(0.0, new_armor)
    slow_multiplier = 1.0
    slow_remaining = 0.0
    dead = false

func tick(delta: float) -> void:
    if slow_remaining <= 0.0:
        slow_multiplier = 1.0
        slow_remaining = 0.0
        return
    slow_remaining = maxf(0.0, slow_remaining - maxf(0.0, delta))
    if slow_remaining <= 0.0:
        slow_multiplier = 1.0

func apply_slow(multiplier: float, duration: float) -> void:
    slow_multiplier = clampf(multiplier, 0.1, 1.0)
    slow_remaining = maxf(slow_remaining, duration)

func move_toward_target(target: Vector2, delta: float) -> void:
    if dead:
        return
    var direction := target - position
    if direction.length_squared() > 1.0:
        position += direction.normalized() * speed * slow_multiplier * maxf(0.0, delta)

func take_damage(amount: float) -> bool:
    if dead:
        return false
    hp = maxf(0.0, hp - maxf(0.0, amount - armor))
    if hp <= 0.0:
        dead = true
    return dead
