class_name AnalyticsContract
extends RefCounted

const SCHEMA_VERSION := 1
const EVENT_NAMES := [
    "hero_selected", "card_played", "card_unused", "match_started", "match_finished",
    "arena_selected", "arena_event_triggered", "reward_received", "card_unlocked",
    "hero_unlocked", "mastery_progressed", "deck_configuration", "energy_spent",
    "match_duration", "result",
    "forge_created", "forge_joined", "forge_left", "forge_war_joined",
    "forge_war_started", "forge_war_battle", "forge_war_contribution",
    "forge_war_completed", "forge_war_rewarded"
]

static func event(name: String, payload: Dictionary = {}) -> Dictionary:
    return {
        "schema_version": SCHEMA_VERSION,
        "event": name,
        "timestamp": 0,
        "payload": payload.duplicate(true)
    }

static func is_supported(name: String) -> bool:
    return name in EVENT_NAMES
