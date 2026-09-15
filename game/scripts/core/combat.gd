class_name CombatSystem
extends RefCounted
func resolve_hit(target:ArenaEnemy,amount:float,direction:Vector2,knockback:float)->bool:
    if target==null or target.dead:return false
    var killed:=target.take_damage(amount)
    if not target.dead and knockback>0.0 and direction.length_squared()>0.01:target.position+=direction.normalized()*knockback
    return killed
func resolve_hero_hit(target:ArenaHero,amount:float,direction:Vector2,knockback:float)->bool:
    if target==null or target.dead:return false
    var killed:=target.take_damage(amount)
    if not target.dead and knockback>0.0 and direction.length_squared()>0.01:target.position+=direction.normalized()*knockback
    return killed
