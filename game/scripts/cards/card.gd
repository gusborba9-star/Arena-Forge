class_name ArenaCard
extends RefCounted
var id := ""
var card_name := ""
var energy_cost := 1.0
var cooldown := 0.0
var effects: Array[CardEffect] = []
static func from_definition(definition: Dictionary) -> ArenaCard:
    var card := ArenaCard.new()
    card.id = str(definition.get("id", ""))
    card.card_name = str(definition.get("name", card.id))
    card.energy_cost = float(definition.get("energy_cost", 1.0))
    card.cooldown = float(definition.get("cooldown", 0.0))
    for effect_data in definition.get("effects", []):
        var effect := CardEffect.new()
        effect.configure(effect_data)
        card.effects.append(effect)
    return card
