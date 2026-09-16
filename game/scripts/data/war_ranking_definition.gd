class_name WarRankingDefinition
extends RefCounted

static func create(data: Dictionary = {}) -> Dictionary:
    return {
        "id": str(data.get("id", "")),
        "entries": data.get("entries", []).duplicate(true),
        "score_field": str(data.get("score_field", "forge_trophies")),
        "tiebreakers": data.get("tiebreakers", []).duplicate(true),
        "finalized": bool(data.get("finalized", false)),
        "closed_at": int(data.get("closed_at", 0))
    }
