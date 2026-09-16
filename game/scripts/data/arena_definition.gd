class_name ArenaDefinition
extends RefCounted

var id := ""
var name := ""
var environment := ""
var terrain := ""
var hazards: Array[String] = []
var elements: Array[String] = []
var tile_types: Array[String] = []
var environmental_rules: Array[Dictionary] = []
var events: Array[Dictionary] = []
var enemy_pool: Array[String] = []
var spawn_rules: Array[Dictionary] = []
var destructibles: Array[Dictionary] = []
var unlock_requirement: Dictionary = {}
var special_rules: Array[Dictionary] = []
var synergy_tags: Array[String] = []
var mastery_id := ""

static func from_dict(value: Dictionary) -> ArenaDefinition:
    var result := ArenaDefinition.new()
    result.id = str(value.get("id", ""))
    result.name = str(value.get("name", result.id))
    result.environment = str(value.get("environment", ""))
    result.terrain = str(value.get("terrain", ""))
    for field in ["hazards", "elements", "tile_types", "enemy_pool", "synergy_tags"]:
        for item in value.get(field, []):
            match field:
                "hazards": result.hazards.append(str(item))
                "elements": result.elements.append(str(item))
                "tile_types": result.tile_types.append(str(item))
                "enemy_pool": result.enemy_pool.append(str(item))
                "synergy_tags": result.synergy_tags.append(str(item))
    result.environmental_rules = value.get("environmental_rules", []).duplicate(true)
    result.events = value.get("events", []).duplicate(true)
    result.spawn_rules = value.get("spawn_rules", []).duplicate(true)
    result.destructibles = value.get("destructibles", []).duplicate(true)
    result.unlock_requirement = value.get("unlock_requirement", {}).duplicate(true)
    result.special_rules = value.get("special_rules", []).duplicate(true)
    result.mastery_id = str(value.get("mastery_id", result.id + "_mastery"))
    return result
