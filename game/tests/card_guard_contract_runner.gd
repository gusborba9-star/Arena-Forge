extends SceneTree
func _init():
 var c=ArenaCard.from_definition(CardDefinitions.initial()[8]);var d=ArenaDeck.new();var a:Array[ArenaCard]=[]
 for i in 8:a.append(c)
 _c(d.set_deck(a),"deck");var r=CardRuntime.new();r.configure(d);var e=EnergyPool.new();e.configure(4,1.5);var x=CardEffectResolver.new();var h=ArenaHero.new();var q={"hero":h,"enemies":[],"arena":ArenaState.new(),"target_position":Vector2.ZERO};_c(not r.play(-1,e,x,q),"index");_c(not r.play(0,e,x,q),"energy");_c(e.current==4 and d.draw_index==4,"unchanged")
 var b=ArenaCard.from_definition(CardDefinitions.initial()[6]);_c(b.cooldown==5,"cooldown");var cards:Array[ArenaCard]=[]
 for i in 8:cards.append(b)
 _c(d.set_deck(cards),"blink deck");r.configure(d);e.configure(10,1.5);_c(r.play(0,e,x,q),"blink first");var v=e.current;_c(not r.play(0,e,x,q) and e.current==v,"blocked");r.tick(5);_c(r.play(0,e,x,q),"ready")
 print("ARENA_FORGE_CARD_GUARDS_OK invalid=2 cooldown=5");quit()
func _c(v,m):
 if not v:push_error(m);quit(1)
