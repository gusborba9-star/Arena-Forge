class_name SeasonDefinitions
extends RefCounted

static func create(data: Dictionary = {}) -> Dictionary:
    return {
        "id": str(data.get("id", "")),
        "name": str(data.get("name", "")),
        "start_at": int(data.get("start_at", 0)),
        "end_at": int(data.get("end_at", 0)),
        "war_ids": data.get("war_ids", []).duplicate(true),
        "ruleset_id": str(data.get("ruleset_id", "")),
        "special_arena_id": str(data.get("special_arena_id", "")),
        "rewards_id": str(data.get("rewards_id", "")),
        "ranking": data.get("ranking", {}).duplicate(true),
        "visual_identity": data.get("visual_identity", {}).duplicate(true)
    }
