class_name ArenaHero
extends RefCounted

var id := "elf"
var hp := 120.0
var max_hp := 120.0
var damage := 14.0
var speed := 260.0
var armor := 0.0
var dead := false
var position := Vector2.ZERO

func configure(definition: Dictionary) -> void:
    id = str(definition.get("id", id))
    max_hp = float(definition.get("hp", max_hp))
    hp = max_hp
    damage = float(definition.get("damage", damage))
    speed = float(definition.get("speed", speed))
    armor = float(definition.get("armor", armor))
    dead = false

func move(direction: Vector2, delta: float) -> void:
    if dead:
        return
    if direction.length_squared() > 1.0:
        direction = direction.normalized()
    position += direction * speed * delta

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
