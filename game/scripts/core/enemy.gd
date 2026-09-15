class_name ArenaEnemy
extends RefCounted

enum Role { CHASER, RANGED, TANK, SWARM, ELITE }

var role := Role.CHASER
var hp := 40.0
var max_hp := 40.0
var damage := 8.0
var speed := 90.0
var armor := 0.0
var dead := false
var position := Vector2.ZERO

func configure(new_role: Role, new_hp: float, new_damage: float, new_speed: float, new_armor: float) -> void:
    role = new_role
    max_hp = new_hp
    hp = new_hp
    damage = new_damage
    speed = new_speed
    armor = new_armor
    dead = false

func move_toward_target(target: Vector2, delta: float) -> void:
    if dead:
        return
    var direction := target - position
    if direction.length_squared() > 1.0:
        position += direction.normalized() * speed * delta

func take_damage(amount: float) -> bool:
    if dead:
        return false
    hp = maxf(0.0, hp - maxf(0.0, amount - armor))
    if hp <= 0.0:
        dead = true
    return dead
