class_name ForgeGuildDefinition
extends RefCounted

static func create(data: Dictionary = {}) -> Dictionary:
    return {
        "id": str(data.get("id", "")),
        "name": str(data.get("name", "")),
        "description": str(data.get("description", "")),
        "emblem": str(data.get("emblem", "")),
        "members": data.get("members", []).duplicate(true),
        "leader_id": str(data.get("leader_id", "")),
        "officer_ids": data.get("officer_ids", []).duplicate(true),
        "level": maxi(1, int(data.get("level", 1))),
        "trophies": maxi(0, int(data.get("trophies", 0))),
        "season_id": str(data.get("season_id", "")),
        "statistics": data.get("statistics", {}).duplicate(true),
        "rules": data.get("rules", {}).duplicate(true),
        "configuration": data.get("configuration", {}).duplicate(true),
        "history": data.get("history", []).duplicate(true)
    }
