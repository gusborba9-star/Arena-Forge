class_name WarScoringDefinitions
extends RefCounted

static func create(data: Dictionary = {}) -> Dictionary:
    return {
        "id": str(data.get("id", "")),
        "victory": data.get("victory", {}).duplicate(true),
        "defeat": data.get("defeat", {}).duplicate(true),
        "strength_difference": data.get("strength_difference", {}).duplicate(true),
        "objectives": data.get("objectives", {}).duplicate(true),
        "bonuses": data.get("bonuses", []).duplicate(true),
        "limits": data.get("limits", {}).duplicate(true),
        "max_contribution": data.get("max_contribution", null),
        "multipliers": data.get("multipliers", {}).duplicate(true)
    }
