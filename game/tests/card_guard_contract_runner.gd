extends SceneTree
func _init():
 var c=ArenaCard.from_definition(CardDefinitions.initial()[8]);var d=ArenaDeck.new();var a:Array[ArenaCard]=[]
 for i in 8:a.append(c)
 d.set_deck(a);var r=CardRuntime.new();r.configure(d);var e=EnergyPool.new();e.configure(4,1.5);var x=CardEffectResolver.new();var h=ArenaHero.new();var q={"hero":h,"enemies":[],"arena":ArenaState.new(),"target_position":Vector2.ZERO};assert(not r.play(-1,e,x,q));assert(not r.play(0,e,x,q));assert(e.current==4 and d.draw_index==4)
 var b=ArenaCard.from_definition(CardDefinitions.initial()[6]);assert(b.cooldown==5);d.set_deck(a.duplicate());var cards:Array[ArenaCard]=[]
 for i in 8:cards.append(b)
 d.set_deck(cards);r.configure(d);e.configure(10,1.5);assert(r.play(0,e,x,q));var v=e.current;assert(not r.play(0,e,x,q) and e.current==v);r.tick(5);assert(r.play(0,e,x,q));print("ARENA_FORGE_CARD_GUARDS_OK invalid=2 cooldown=5");quit()
