class_name BuildState
extends RefCounted

var bonuses := {"damage": 0.0, "speed": 0.0, "max_hp": 0.0, "armor": 0.0}

func apply_upgrade(offer: UpgradeOffer) -> bool:
    if offer == null:
        return false
    for key in bonuses.keys():
        bonuses[key] += float(offer.effects.get(key, 0.0))
    return true

func apply_to_hero(hero: ArenaHero) -> void:
    if hero == null:
        return
    hero.damage = hero.base_damage + float(bonuses.damage)
    hero.speed = hero.base_speed + float(bonuses.speed)
    hero.armor = hero.base_armor + float(bonuses.armor)
    hero.max_hp = hero.base_hp + float(bonuses.max_hp)
    hero.hp = minf(hero.max_hp, hero.hp + float(bonuses.max_hp))
