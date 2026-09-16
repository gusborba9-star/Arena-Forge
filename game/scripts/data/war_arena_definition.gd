class_name WarArenaDefinition
extends RefCounted

static func create(data: Dictionary = {}) -> Dictionary:
    return {
        "id": str(data.get("id", "")),
        "name": str(data.get("name", "")),
        "terrain": str(data.get("terrain", "")),
        "hazards": data.get("hazards", []).duplicate(true),
        "events": data.get("events", []).duplicate(true),
        "rules": data.get("rules", {}).duplicate(true),
        "modifiers": data.get("modifiers", []).duplicate(true),
        "objectives": data.get("objectives", []).duplicate(true),
        "visual_identity": data.get("visual_identity", {}).duplicate(true)
    }
