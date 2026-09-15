class_name ContentValidation
extends RefCounted

const EFFECT_KINDS := ["damage", "heal", "push", "speed", "tile", "destroy", "spawn", "slow"]

static func validate() -> Dictionary:
    var heroes := HeroDefinitions.initial()
    var cards := CardDefinitions.initial()
    var arenas := ArenaDefinitions.initial()
    var hero_ids := {}
    var card_ids := {}
    var arena_ids := {}
    var valid := heroes.size() == 4 and cards.size() == 16 and arenas.size() == 15

    for hero in heroes:
        var hero_id := str(hero.get("id", ""))
        valid = valid and not hero_id.is_empty() and not hero_ids.has(hero_id)
        valid = valid and float(hero.get("hp", -1.0)) > 0.0 and float(hero.get("damage", -1.0)) >= 0.0 and float(hero.get("speed", -1.0)) >= 0.0 and float(hero.get("armor", -1.0)) >= 0.0
        hero_ids[hero_id] = true

    for card in cards:
        var card_id := str(card.get("id", ""))
        var cost := float(card.get("energy_cost", -1.0))
        var effects: Array = card.get("effects", [])
        valid = valid and not card_id.is_empty() and not card_ids.has(card_id) and cost >= 0.0 and cost <= 10.0 and not effects.is_empty()
        card_ids[card_id] = true
        for effect in effects:
            var kind := str(effect.get("kind", ""))
            valid = valid and kind in EFFECT_KINDS
            valid = valid and float(effect.get("value", 0.0)) >= 0.0 and float(effect.get("area", 0.0)) >= 0.0 and float(effect.get("duration", 0.0)) >= 0.0

    for arena in arenas:
        var arena_id := str(arena.get("id", ""))
        valid = valid and not arena_id.is_empty() and not arena_ids.has(arena_id)
        arena_ids[arena_id] = true

    return {"heroes": heroes.size(), "cards": cards.size(), "arenas": arenas.size(), "valid": valid}
