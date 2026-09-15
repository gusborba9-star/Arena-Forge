extends SceneTree
const I=["ice_wall","wind_blast","oil_pool","spark_bomb","healing_pillar","water_geyser","blink","goblin_invasion","meteor","snowstorm","black_hole","brute_invasion","earth_spikes","air_current","overload","shock_chain"]
const C=[3,2,2,3,3,2,2,4,5,4,5,5,3,2,4,4]
func _init():
 var d=CardDefinitions.initial();_c(d.size()==16,"count");var cat=ContentCatalog.new()
 for i in 16:
  var c=ArenaCard.from_definition(d[i]);_c(c.id==I[i] and c.energy_cost==C[i],I[i]);cat.register_card(d[i])
 _c(cat.cards.size()==16,"catalog");var a:Array[ArenaCard]=[]
 for i in 8:a.append(ArenaCard.from_definition(d[i]))
 var q=ArenaDeck.new();_c(q.set_deck(a),"deck");_c(q.hand.size()==4 and q.draw_index==4,"hand");var f=q.hand[0].id;var n=q.deck[4].id;_c(q.play(0).id==f and q.hand[0].id==n and q.draw_index==5,"draw")
 print("ARENA_FORGE_CARD_DATA_OK cards=16");quit()
func _c(v,m):
 if not v:push_error(m);quit(1)
