class_name MasteryDefinition
extends RefCounted

var id := ""
var target_type := ""
var target_id := ""
var milestones: Array[Dictionary] = []
var reward_policy: Dictionary = {}

static func from_dict(value: Dictionary) -> MasteryDefinition:
    var result := MasteryDefinition.new()
    result.id = str(value.get("id", ""))
    result.target_type = str(value.get("target_type", ""))
    result.target_id = str(value.get("target_id", ""))
    result.milestones = value.get("milestones", []).duplicate(true)
    result.reward_policy = value.get("reward_policy", {}).duplicate(true)
    return result
