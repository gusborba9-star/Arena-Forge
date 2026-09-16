class_name ForgeWarDefinitions
extends RefCounted

const STATES := ["SCHEDULED", "PREPARATION", "ACTIVE", "FINALIZING", "COMPLETED"]

static func war(data: Dictionary = {}) -> Dictionary:
    return {
        "id": str(data.get("id", "")),
        "season_id": str(data.get("season_id", "")),
        "status": str(data.get("status", "SCHEDULED")),
        "start_at": int(data.get("start_at", 0)),
        "preparation_at": int(data.get("preparation_at", 0)),
        "battle_start_at": int(data.get("battle_start_at", 0)),
        "end_at": int(data.get("end_at", 0)),
        "duration_seconds": maxi(0, int(data.get("duration_seconds", 0))),
        "participating_forges": data.get("participating_forges", []).duplicate(true),
        "ruleset_id": str(data.get("ruleset_id", "")),
        "war_arena_id": str(data.get("war_arena_id", "")),
        "battles": data.get("battles", []).duplicate(true),
        "individual_contributions": data.get("individual_contributions", {}).duplicate(true),
        "forge_trophies": data.get("forge_trophies", {}).duplicate(true),
        "ranking": data.get("ranking", []).duplicate(true),
        "rewards": data.get("rewards", {}).duplicate(true)
    }

static func initial_cycle() -> Dictionary:
    return {
        "preparation_seconds": 86400,
        "active_seconds": 172800,
        "finalization_seconds": 0
    }

static func is_valid_state(value: String) -> bool:
    return value in STATES
