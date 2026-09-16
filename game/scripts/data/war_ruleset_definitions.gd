class_name WarRulesetDefinitions
extends RefCounted

static func create(data: Dictionary = {}) -> Dictionary:
    return {
        "id": str(data.get("id", "")),
        "hero_level_normalization": data.get("hero_level_normalization", {}).duplicate(true),
        "card_level_normalization": data.get("card_level_normalization", {}).duplicate(true),
        "deck_restrictions": data.get("deck_restrictions", {}).duplicate(true),
        "card_restrictions": data.get("card_restrictions", {}).duplicate(true),
        "hero_restrictions": data.get("hero_restrictions", {}).duplicate(true),
        "arena_modifiers": data.get("arena_modifiers", []).duplicate(true),
        "event_frequency": data.get("event_frequency", {}).duplicate(true),
        "battle_attempts": data.get("battle_attempts", {}).duplicate(true),
        "scoring_ruleset_id": str(data.get("scoring_ruleset_id", "")),
        "contribution_ruleset_id": str(data.get("contribution_ruleset_id", "")),
        "objectives": data.get("objectives", []).duplicate(true),
        "rewards_id": str(data.get("rewards_id", ""))
    }
