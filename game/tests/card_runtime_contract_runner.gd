extends SceneTree
func _init():
 var d=CardDefinitions.initial();assert(d.size()==16)
 for z in d:_t(ArenaCard.from_definition(z))
 print("ARENA_FORGE_CARD_RUNTIME_OK cards=16");quit()
func _t(c):
 var q=ArenaDeck.new();var a:Array[ArenaCard]=[]
 for i in 8:a.append(c)
 q.set_deck(a);var e=EnergyPool.new();e.configure(10,1.5);var r=CardRuntime.new();r.configure(q);var x=CardEffectResolver.new();var h=ArenaHero.new();var ar=ArenaState.new();var n=ArenaEnemy.new();n.position=Vector2(150,40);var z={"hero":h,"enemies":[n],"arena":ar,"target_position":Vector2(100,40)};var hp=n.hp;var p=n.position
 if c.id=="healing_pillar":h.take_damage(40)
 assert(r.play(0,e,x,z))
 for f in c.effects:
  if f.kind=="damage":assert(n.hp<hp)
  elif f.kind=="heal":assert(h.hp>0)
  elif f.kind=="push":assert(n.position!=p)
  elif f.kind=="tile":assert(ar.get_tile(0,0)!=ArenaState.Tile.NORMAL)
  elif f.kind=="speed":assert(z.has("hero_speed_multiplier"))
  elif f.kind=="spawn":assert(z.has("spawn_request"))
  elif f.kind=="slow":assert(n.slow_remaining>0)
