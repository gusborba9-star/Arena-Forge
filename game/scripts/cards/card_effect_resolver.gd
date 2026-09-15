class_name CardEffectResolver
extends RefCounted

func resolve(card: ArenaCard, context: Dictionary) -> bool:
    if card == null:
        return false
    var hero: ArenaHero = context.get("hero")
    var enemies: Array = context.get("enemies", [])
    var arena: ArenaState = context.get("arena")
    var target: Vector2 = context.get("target_position", hero.position if hero else Vector2.ZERO)
    for effect in card.effects:
        match effect.kind:
            "damage":
                for enemy in enemies:
                    if not enemy.dead and enemy.position.distance_to(target) <= effect.area:
                        enemy.take_damage(effect.value)
            "heal":
                if hero:
                    hero.heal(effect.value)
            "push":
                for enemy in enemies:
                    if not enemy.dead and enemy.position.distance_to(target) <= effect.area and enemy.position.distance_squared_to(target) > 0.01:
                        enemy.position += target.direction_to(enemy.position) * effect.value
            "speed":
                context["hero_speed_multiplier"] = 1.0 + effect.value
                context["hero_speed_duration"] = effect.duration
            "tile":
                if arena:
                    var p := arena.world_to_tile(target)
                    arena.set_tile(p.x, p.y, _tile_from_id(effect.tile_id))
            "destroy":
                if arena:
                    var p2 := arena.world_to_tile(target)
                    arena.destroy_tile(p2.x, p2.y)
            "spawn":
                context["spawn_request"] = {"kind": effect.target_type, "count": int(effect.value)}
            "slow":
                for enemy in enemies:
                    if not enemy.dead and enemy.position.distance_to(target) <= effect.area:
                        enemy.apply_slow(clampf(1.0 - effect.value, 0.1, 1.0), effect.duration)
    return true

func _tile_from_id(id: String) -> ArenaState.Tile:
    match id.to_lower():
        "water": return ArenaState.Tile.WATER
        "ice": return ArenaState.Tile.ICE
        "fire": return ArenaState.Tile.FIRE
        "oil": return ArenaState.Tile.OIL
        "electricity", "electric": return ArenaState.Tile.ELECTRIC
        "hazard": return ArenaState.Tile.HAZARD
        _: return ArenaState.Tile.NORMAL
