class_name BuildState
extends RefCounted
var bonuses := {"damage": 0.0, "speed": 0.0, "max_hp": 0.0, "armor": 0.0}
func apply_upgrade(offer: UpgradeOffer) -> bool:
    if offer == null: return false
    for key in bonuses.keys(): bonuses[key] += float(offer.effects.get(key, 0.0))
    return true
func apply_to_hero(hero: ArenaHero) -> void:
    hero.damage = 14.0 + float(bonuses.damage)
    hero.speed = 260.0 + float(bonuses.speed)
    hero.armor = float(bonuses.armor)
    hero.max_hp = 120.0 + float(bonuses.max_hp)
    hero.hp = minf(hero.max_hp, hero.hp + float(bonuses.max_hp))
