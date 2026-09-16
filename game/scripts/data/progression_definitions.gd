class_name ProgressionDefinitions
extends RefCounted

static func launch_target() -> Dictionary:
    return {
        "target_cards": 25,
        "target_heroes": 8,
        "target_arenas": 15,
        "deck_size": 8,
        "hand_size": 4,
        "progression_model": "arena_unlock",
        "unlock_distribution": "data_driven"
    }

static func trophy_road() -> Array[Dictionary]:
    return [
        {"arena": 1, "trophies": 0, "unlocks": ["cards", "starter_rewards"]},
        {"arena": 2, "trophies": 100, "unlocks": ["cards", "mastery"]},
        {"arena": 3, "trophies": 250, "unlocks": ["cards", "hero"]},
        {"arena": 4, "trophies": 450, "unlocks": ["cards", "events"]},
        {"arena": 5, "trophies": 700, "unlocks": ["cards", "mastery"]}
    ]
