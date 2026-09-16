class_name ArenaDefinitions
extends RefCounted

static func initial() -> Array[Dictionary]:
    return [
        {"id":"arena_1","name":"Campo de Batalha","environment":"battlefield","terrain":"open","hazards":["fire_patch","ground_break"],"elements":["fire","earth"],"tile_types":["normal","fire","cracked","collapsed","abyss"],"events":[{"id":"fire_patch","warning_seconds":1.5,"cooldown_seconds":18.0,"mutation":"fire_hazard"},{"id":"ground_break","warning_seconds":1.8,"cooldown_seconds":20.0,"mutation":"destroy_tile"}],"enemy_pool":["chaser","ranged","tank","swarm","elite"],"unlock_requirement":{"trophies":0},"synergy_tags":["ARENA","FIRE","DESTRUCTION"],"mastery_id":"arena_1_mastery"},
        {"id":"arena_2","name":"Selva","environment":"jungle","terrain":"wet","hazards":["moving_water"],"elements":["water","nature"],"unlock_requirement":{"trophies":100},"synergy_tags":["NATURE","WATER","ARENA"],"mastery_id":"arena_2_mastery"},
        {"id":"arena_3","name":"Tundra","environment":"tundra","terrain":"frozen","hazards":["blizzard","freeze_zone"],"elements":["ice"],"unlock_requirement":{"trophies":250},"synergy_tags":["ICE","CONTROL","ARENA"],"mastery_id":"arena_3_mastery"},
        {"id":"arena_4","name":"Vulcão","environment":"volcano","terrain":"lava","hazards":["eruption","lava_splash"],"elements":["fire"],"unlock_requirement":{"trophies":450},"synergy_tags":["FIRE","DESTRUCTION","ARENA"],"mastery_id":"arena_4_mastery"},
        {"id":"arena_5","name":"Terremoto","environment":"earthquake","terrain":"unstable","hazards":["quake","crack_chain"],"elements":["earth"],"unlock_requirement":{"trophies":700},"synergy_tags":["DESTRUCTION","ARENA"],"mastery_id":"arena_5_mastery"},
        {"id":"arena_6","name":"Cânion","environment":"canyon","terrain":"vertical","hazards":["rockfall"],"unlock_requirement":{"trophies":1000},"mastery_id":"arena_6_mastery"},
        {"id":"arena_7","name":"Arquipélago","environment":"archipelago","terrain":"islands","hazards":["tide"],"unlock_requirement":{"trophies":1350},"mastery_id":"arena_7_mastery"},
        {"id":"arena_8","name":"Tempestade","environment":"storm","terrain":"exposed","hazards":["lightning","wind"],"unlock_requirement":{"trophies":1750},"mastery_id":"arena_8_mastery"},
        {"id":"arena_9","name":"Ruínas","environment":"ruins","terrain":"broken","hazards":["collapse"],"unlock_requirement":{"trophies":2200},"mastery_id":"arena_9_mastery"},
        {"id":"arena_10","name":"Deserto","environment":"desert","terrain":"sand","hazards":["sand_wave","heat"],"unlock_requirement":{"trophies":2700},"mastery_id":"arena_10_mastery"},
        {"id":"arena_11","name":"Abismo","environment":"abyss","terrain":"void","hazards":["void_pull"],"unlock_requirement":{"trophies":3250},"mastery_id":"arena_11_mastery"},
        {"id":"arena_12","name":"Floresta Sombria","environment":"dark_forest","terrain":"dense","hazards":["shadow_zone"],"unlock_requirement":{"trophies":3850},"mastery_id":"arena_12_mastery"},
        {"id":"arena_13","name":"Ilhas Celestes","environment":"skylands","terrain":"floating","hazards":["updraft","fall_zone"],"unlock_requirement":{"trophies":4500},"mastery_id":"arena_13_mastery"},
        {"id":"arena_14","name":"Laboratório","environment":"laboratory","terrain":"experimental","hazards":["overload","unstable_field"],"unlock_requirement":{"trophies":5200},"mastery_id":"arena_14_mastery"},
        {"id":"arena_15","name":"Caos","environment":"chaos","terrain":"dynamic","hazards":["rotation","mixed_events"],"unlock_requirement":{"trophies":6000},"mastery_id":"arena_15_mastery"}
    ]
