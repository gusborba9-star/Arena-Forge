extends SceneTree
func _init():
 var d=CardDefinitions.initial();_check(d.size()==16,"16 cards")
 for z in d:_t(ArenaCard.from_definition(z))
 print("ARENA_FORGE_CARD_RUNTIME_OK cards=16");quit()
func _check(v,m):
 if not v: push_error(m);quit(1)
func _t(c):
 var q=ArenaDeck.new();var a:Array[ArenaCard]=[]
 for i in 8:a.append(c)
 _check(q.set_deck(a),"deck");var e=EnergyPool.new();e.configure(10,1.5);var r=CardRuntime.new();r.configure(q);var x=CardEffectResolver.new();var h=ArenaHero.new();var ar=ArenaState.new();var n=ArenaEnemy.new();n.configure(ArenaEnemy.Role.CHASER,200,10,90,0);n.position=Vector2(150,40);var z={"hero":h,"enemies":[n],"arena":ar,"target_position":Vector2(100,40)};var hp=n.hp;var p=n.position
 if c.id=="healing_pillar":h.take_damage(40)
 var ep=e.current;_check(r.play(0,e,x,z),c.id+" play");_check(is_equal_approx(e.current,ep-c.energy_cost),c.id+" energy");_check(q.hand.size()==4 and q.draw_index==5,c.id+" deck")
 for f in c.effects:
  if f.kind=="damage":_check(n.hp<hp,c.id+" damage")
  elif f.kind=="heal":_check(h.hp==115,c.id+" heal")
  elif f.kind=="push":_check(n.position!=p,c.id+" push")
  elif f.kind=="tile":_check(ar.get_tile(0,0)!=ArenaState.Tile.NORMAL,c.id+" tile")
  elif f.kind=="speed":_check(z.has("hero_speed_multiplier"),c.id+" speed")
  elif f.kind=="spawn":_check(z.has("spawn_request"),c.id+" spawn")
  elif f.kind=="slow":_check(n.slow_remaining>0,c.id+" slow")
