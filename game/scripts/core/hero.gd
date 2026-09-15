class_name ArenaHero
extends RefCounted

var id := "elf"
var hp := 120.0
var max_hp := 120.0
var damage := 14.0
var speed := 260.0
var armor := 0.0
var base_hp := 120.0
var base_damage := 14.0
var base_speed := 260.0
var base_armor := 0.0
var dead := false
var position := Vector2.ZERO

func configure(definition: Dictionary) -> void:
    id = str(definition.get("id", id))
    base_hp = maxf(0.0, float(definition.get("hp", base_hp)))
    base_damage = maxf(0.0, float(definition.get("damage", base_damage)))
    base_speed = maxf(0.0, float(definition.get("speed", base_speed)))
    base_armor = maxf(0.0, float(definition.get("armor", base_armor)))
    max_hp = base_hp
    hp = max_hp
    damage = base_damage
    speed = base_speed
    armor = base_armor
    dead = false

func move(direction: Vector2, delta: float) -> void:
    if dead:
        return
    if direction.length_squared() > 1.0:
        direction = direction.normalized()
    position += direction * speed * maxf(0.0, delta)

func take_damage(amount: float) -> bool:
    if dead:
        return false
    hp = maxf(0.0, hp - maxf(0.0, amount - armor))
    if hp <= 0.0:
        dead = true
    return dead

func heal(amount: float) -> void:
    if not dead:
        hp = minf(max_hp, hp + maxf(0.0, amount))
