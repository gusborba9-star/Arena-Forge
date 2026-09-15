class_name ArenaRuntimeDefinitions
extends RefCounted

static func arena_1() -> Dictionary:
    return {
        "id": "arena_1",
        "name": "Campo de Batalha",
        "environment": "temperate",
        "events": [
            {"id": "fire_patch", "type": "element", "element": "fire", "warning_seconds": 1.5, "duration_seconds": 4.0, "cooldown_seconds": 18.0},
            {"id": "ground_break", "type": "destruction", "warning_seconds": 1.8, "duration_seconds": 2.0, "cooldown_seconds": 18.0}
        ]
    }
