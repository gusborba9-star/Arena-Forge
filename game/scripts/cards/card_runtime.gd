class_name CardRuntime
extends RefCounted
var deck: ArenaDeck
var cooldowns := CooldownTracker.new()
func configure(value: ArenaDeck) -> void: deck = value
func tick(delta: float) -> void: cooldowns.tick(delta)
func play(index: int, energy: EnergyPool, resolver: CardEffectResolver, context: Dictionary) -> bool:
    if deck == null or index < 0 or index >= deck.hand.size(): return false
    var card: ArenaCard = deck.hand[index]
    if not cooldowns.ready(card.id) or not energy.spend(card.energy_cost): return false
    if not resolver.resolve(card, context): return false
    deck.play(index)
    cooldowns.start(card.id, card.cooldown)
    return true
