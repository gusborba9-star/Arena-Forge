class_name RewardDefinitions
extends RefCounted

static func reward_schema() -> Dictionary:
    return {
        "types": ["card", "fragment", "resource", "cosmetic", "choice"],
        "choice_policy": {"enabled": true, "min_options": 2, "max_options": 5},
        "source_types": ["match", "chest", "forge", "event", "mastery", "season"]
    }

static func chest_schema() -> Dictionary:
    return {
        "id": "forge_crate",
        "selection_policy": "optional_choice",
        "supports_weighted_rolls": true,
        "supports_choice_of_n": true
    }
