class_name CompetitiveDefinitions
extends RefCounted

static func normalized_ruleset() -> Dictionary:
    return {
        "id": "normalized",
        "normalization": {"hero_level": "fixed", "card_level": "fixed"},
        "future_variables": ["forge_power", "temporary_modifiers"]
    }

static func tournament_contract() -> Dictionary:
    return {
        "id": "arena_tournament",
        "ruleset_id": "normalized",
        "matchmaking": "external_contract",
        "leaderboard": "external_contract"
    }
