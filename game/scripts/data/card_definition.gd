class_name CardDefinition
extends RefCounted

var id := ""
var name := ""
var rarity := "common"
var category := "spell"
var energy_cost := 0
var cooldown := 0.0
var effects: Array[Dictionary] = []
var tags: Array[String] = []
var unlock_arena := 1
var mastery_id := ""
var synergy_tags: Array[String] = []
var forge_id := ""

static func from_dict(value: Dictionary) -> CardDefinition:
    var result := CardDefinition.new()
    result.id = str(value.get("id", ""))
    result.name = str(value.get("name", result.id))
    result.rarity = str(value.get("rarity", "common"))
    result.category = str(value.get("category", "spell"))
    result.energy_cost = maxi(0, int(value.get("energy_cost", 0)))
    result.cooldown = maxf(0.0, float(value.get("cooldown", 0.0)))
    for effect in value.get("effects", []):
        result.effects.append(effect.duplicate(true))
    for tag in value.get("tags", []):
        result.tags.append(str(tag))
    result.unlock_arena = maxi(1, int(value.get("unlock_arena", 1)))
    result.mastery_id = str(value.get("mastery_id", result.id + "_mastery"))
    for tag in value.get("synergy_tags", result.tags):
        result.synergy_tags.append(str(tag))
    result.forge_id = str(value.get("forge_id", result.id + "_forge"))
    return result
