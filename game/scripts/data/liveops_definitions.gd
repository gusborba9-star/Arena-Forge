class_name LiveOpsDefinitions
extends RefCounted

static func event_contract() -> Dictionary:
    return {"id": "event", "schedule": {}, "ruleset_id": "", "rewards": [], "content_rotation": []}

static func season_contract() -> Dictionary:
    return {"id": "season", "start": "", "end": "", "pass_id": "", "ruleset_id": "", "content_rotation": []}

static func rotation_contract() -> Dictionary:
    return {"id": "rotation", "content_ids": [], "starts_at": "", "ends_at": ""}
