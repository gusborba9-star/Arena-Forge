class_name ContentValidation
extends RefCounted
static func validate() -> Dictionary:
    var heroes := HeroDefinitions.initial()
    var cards := CardDefinitions.initial()
    var arenas := ArenaDefinitions.initial()
    return {"heroes":heroes.size(),"cards":cards.size(),"arenas":arenas.size(),"valid":heroes.size() >= 4 and cards.size() >= 16 and arenas.size() == 15}
