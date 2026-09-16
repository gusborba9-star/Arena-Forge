class_name HeroDefinition
extends RefCounted

var id := ""
var role := ""
var hp := 0.0
var damage := 0.0
var speed := 0.0
var armor := 0.0
var attack_range := 0.0
var ability_id := ""
var tags: Array[String] = []
var mastery_id := ""
var specialization_id := ""

static func from_dict(value: Dictionary) -> HeroDefinition:
    var result := HeroDefinition.new()
    result.id = str(value.get("id", ""))
    result.role = str(value.get("role", ""))
    result.hp = maxf(0.0, float(value.get("hp", 0.0)))
    result.damage = maxf(0.0, float(value.get("damage", 0.0)))
    result.speed = maxf(0.0, float(value.get("speed", 0.0)))
    result.armor = maxf(0.0, float(value.get("armor", 0.0)))
    result.attack_range = maxf(0.0, float(value.get("attack_range", 0.0)))
    result.ability_id = str(value.get("ability_id", ""))
    for tag in value.get("tags", []):
        result.tags.append(str(tag))
    result.mastery_id = str(value.get("mastery_id", result.id + "_mastery"))
    result.specialization_id = str(value.get("specialization_id", result.id + "_specialization"))
    return result
