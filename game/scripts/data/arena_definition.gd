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
    for item in value.get("hazards", []): result.hazards.append(str(item))
    for item in value.get("elements", []): result.elements.append(str(item))
    for item in value.get("tile_types", []): result.tile_types.append(str(item))
    for item in value.get("enemy_pool", []): result.enemy_pool.append(str(item))
    for item in value.get("synergy_tags", []): result.synergy_tags.append(str(item))
    for item in value.get("environmental_rules", []): result.environmental_rules.append(item.duplicate(true))
    for item in value.get("events", []): result.events.append(item.duplicate(true))
    for item in value.get("spawn_rules", []): result.spawn_rules.append(item.duplicate(true))
    for item in value.get("destructibles", []): result.destructibles.append(item.duplicate(true))
    result.unlock_requirement = value.get("unlock_requirement", {}).duplicate(true)
    for item in value.get("special_rules", []): result.special_rules.append(item.duplicate(true))
    result.mastery_id = str(value.get("mastery_id", result.id + "_mastery"))
    return result
