extends SceneTree
func _init():
 var ds=CardDefinitions.initial(); assert(ds.size()==16)
 for d in ds:
  var c=ArenaCard.from_definition(d); var deck=ArenaDeck.new(); var a:Array[ArenaCard]=[]
  for i in 8:a.append(c)
  assert(deck.set_deck(a)); var e=EnergyPool.new(); e.configure(10,1.5); var r=CardRuntime.new(); r.configure(deck); var x=CardEffectResolver.new(); var h=ArenaHero.new(); h.configure(HeroDefinitions.initial()[0]); var ar=ArenaState.new(); var n=ArenaEnemy.new(); n.configure(ArenaEnemy.Role.CHASER,200,10,90,0); n.position=Vector2(150,40); var q={"hero":h,"enemies":[n],"arena":ar,"target_position":Vector2(100,40)}; var hp=n.hp; var p=n.position; var ep=e.current
  for f in c.effects: if f.kind=="heal":h.take_damage(40)
  assert(r.play(0,e,x,q)); assert(is_equal_approx(e.current,ep-c.energy_cost)); assert(deck.hand.size()==4 and deck.draw_index==5)
  for f in c.effects: match f.kind:
   "damage":assert(n.hp<hp)
   "heal":assert(h.hp>0)
   "push":assert(n.position!=p)
   "tile":assert(ar.get_tile(0,0)!=ArenaState.Tile.NORMAL)
   "speed":assert(q.has("hero_speed_multiplier"))
   "spawn":assert(q.has("spawn_request"))
   "slow":assert(n.slow_remaining>0)
 print("ARENA_FORGE_CARD_RUNTIME_OK cards=16"); quit()
