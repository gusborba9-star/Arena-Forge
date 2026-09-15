extends SceneTree
func _init():
 var d=CardDefinitions.initial();assert(d.size()==16)
 for z in d:_t(ArenaCard.from_definition(z))
 quit()
func _t(c):
 var q=ArenaDeck.new();var a:Array[ArenaCard]=[]
 for i in 8:a.append(c)
 q.set_deck(a);var e=EnergyPool.new();e.configure(10,1.5);var r=CardRuntime.new();r.configure(q);var x=CardEffectResolver.new();var h=ArenaHero.new();var ar=ArenaState.new();var n=ArenaEnemy.new();n.position=Vector2(150,40);var cxt={"hero":h,"enemies":[n],"arena":ar,"target_position":Vector2(100,40)};var hp=n.hp;var p=n.position
 if c.id=="healing_pillar":h.take_damage(40)
 assert(r.play(0,e,x,cxt))
 for f in c.effects:match f.kind:
  "damage":assert(n.hp<hp)
  "heal":assert(h.hp>0)
  "push":assert(n.position!=p)
  "tile":assert(ar.get_tile(0,0)!=ArenaState.Tile.NORMAL)
  "speed":assert(cxt.has("hero_speed_multiplier"))
  "spawn":assert(cxt.has("spawn_request"))
  "slow":assert(n.slow_remaining>0)
