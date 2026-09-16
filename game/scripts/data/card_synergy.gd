class_name CardSynergy
extends RefCounted

const VOCABULARY := [
    "SWARM", "FIRE", "ICE", "CONTROL", "MOBILITY", "DEFENSE", "OFFENSE",
    "ARENA", "NATURE", "RANGED", "ELEMENTAL", "DESTRUCTION", "HEALING", "PUSH"
]

static func tags_for(card: Dictionary) -> Array[String]:
    var tags: Array[String] = []
    for tag in card.get("synergy_tags", card.get("tags", [])):
        var normalized := str(tag).to_upper()
        if normalized in VOCABULARY and normalized not in tags:
            tags.append(normalized)
    return tags

static func matches(card_a: Dictionary, card_b: Dictionary) -> bool:
    var a := tags_for(card_a)
    for tag in tags_for(card_b):
        if tag in a:
            return true
    return false

static func match_context(hero: Dictionary, card: Dictionary, arena: Dictionary) -> Array[String]:
    var context: Array[String] = []
    for tag in hero.get("tags", []):
        if str(tag).to_upper() in tags_for(card) and str(tag).to_upper() not in context:
            context.append(str(tag).to_upper())
    for tag in arena.get("synergy_tags", []):
        if str(tag).to_upper() in tags_for(card) and str(tag).to_upper() not in context:
            context.append(str(tag).to_upper())
    return context
