class_name ForgeDefinition
extends RefCounted

var id := ""
var target_type := ""
var target_id := ""
var options: Array[Dictionary] = []
var normalized_mode_policy: Dictionary = {}

static func from_dict(value: Dictionary) -> ForgeDefinition:
    var result := ForgeDefinition.new()
    result.id = str(value.get("id", ""))
    result.target_type = str(value.get("target_type", ""))
    result.target_id = str(value.get("target_id", ""))
    for option in value.get("options", []):
        result.options.append(option.duplicate(true))
    result.normalized_mode_policy = value.get("normalized_mode_policy", {}).duplicate(true)
    return result
