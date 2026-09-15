extends SceneTree
func _init() -> void:
    var validation := ContentValidation.validate()
    assert(validation.valid)
    assert(validation.heroes == 4)
    assert(validation.cards == 16)
    assert(validation.arenas == 15)
    var energy := EnergyPool.new(); energy.configure(10.0,1.5); assert(energy.spend(4.0)); assert(is_equal_approx(energy.current,6.0)); energy.tick(1.5); assert(is_equal_approx(energy.current,7.0))
    var arena := ArenaState.new(); assert(arena.destroy_tile(0,0)==ArenaState.Tile.CRACKED); assert(arena.destroy_tile(0,0)==ArenaState.Tile.COLLAPSED); assert(arena.destroy_tile(0,0)==ArenaState.Tile.ABYSS)
    var rules := ArenaRules.resolve_element_interaction("water","electricity"); assert(rules.reaction=="shock_zone")
    var state := MatchState.new(); state.configure(90.0,180.0,240.0); state.tick(181.0); assert(state.phase==MatchState.Phase.CATACLYSM); state.tick(59.0); assert(state.is_result())
    print("ARENA_FORGE_ENGINE_CONTRACTS_OK")
    quit()
