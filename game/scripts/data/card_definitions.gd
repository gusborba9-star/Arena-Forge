class_name CardDefinitions
extends RefCounted

static func initial() -> Array[Dictionary]:
    return [
        {"id":"ice_wall","name":"Muralha de Gelo","rarity":"common","category":"arena","energy_cost":3,"tags":["ICE","DEFENSE","ARENA"],"synergy_tags":["ICE","DEFENSE","ARENA"],"unlock_arena":1,"effects":[{"kind":"tile","tile_id":"ice"}]},
        {"id":"wind_blast","name":"Rajada de Vento","rarity":"common","category":"control","energy_cost":2,"tags":["CONTROL","PUSH"],"synergy_tags":["CONTROL","PUSH","MOBILITY"],"unlock_arena":1,"effects":[{"kind":"push","value":110,"area":170}]},
        {"id":"oil_pool","name":"Poça de Óleo","rarity":"common","category":"arena","energy_cost":2,"tags":["ARENA","CONTROL"],"synergy_tags":["ARENA","CONTROL","FIRE"],"unlock_arena":1,"effects":[{"kind":"tile","tile_id":"oil"}]},
        {"id":"spark_bomb","name":"Bomba de Faísca","rarity":"rare","category":"damage","energy_cost":3,"tags":["OFFENSE","ELEMENTAL"],"synergy_tags":["OFFENSE","FIRE","ELEMENTAL"],"unlock_arena":1,"effects":[{"kind":"damage","value":28,"area":150}]},
        {"id":"healing_pillar","name":"Pilar de Cura","rarity":"rare","category":"support","energy_cost":3,"tags":["HEALING","DEFENSE"],"synergy_tags":["HEALING","DEFENSE"],"unlock_arena":1,"effects":[{"kind":"heal","value":35}]},
        {"id":"water_geyser","name":"Gêiser","rarity":"common","category":"control","energy_cost":2,"tags":["CONTROL","ARENA","PUSH"],"synergy_tags":["CONTROL","ARENA","PUSH","NATURE"],"unlock_arena":1,"effects":[{"kind":"push","value":70,"area":130}]},
        {"id":"blink","name":"Blink","rarity":"rare","category":"mobility","energy_cost":2,"cooldown":5,"tags":["MOBILITY"],"synergy_tags":["MOBILITY","OFFENSE","DEFENSE"],"unlock_arena":1,"effects":[{"kind":"speed","value":1.0,"duration":1}]},
        {"id":"goblin_invasion","name":"Invasão Goblin","rarity":"epic","category":"summon","energy_cost":4,"tags":["SWARM","OFFENSE"],"synergy_tags":["SWARM","OFFENSE","NATURE"],"unlock_arena":1,"effects":[{"kind":"spawn","value":4,"target_type":"goblin"}]},
        {"id":"meteor","name":"Meteoro","rarity":"epic","category":"arena","energy_cost":5,"tags":["FIRE","ARENA","DESTRUCTION"],"synergy_tags":["FIRE","ARENA","DESTRUCTION","OFFENSE"],"unlock_arena":1,"effects":[{"kind":"damage","value":65,"area":190},{"kind":"push","value":90,"area":190},{"kind":"tile","tile_id":"fire"}]},
        {"id":"snowstorm","name":"Nevasca","rarity":"epic","category":"control","energy_cost":4,"tags":["ICE","CONTROL"],"synergy_tags":["ICE","CONTROL","ARENA"],"unlock_arena":2,"effects":[{"kind":"slow","value":0.5,"duration":4,"area":220}]},
        {"id":"black_hole","name":"Buraco Negro","rarity":"legendary","category":"control","energy_cost":5,"tags":["CONTROL","PUSH"],"synergy_tags":["CONTROL","PUSH","DESTRUCTION"],"unlock_arena":2,"effects":[{"kind":"push","value":140,"area":220}]},
        {"id":"brute_invasion","name":"Invasão Bruta","rarity":"epic","category":"summon","energy_cost":5,"tags":["OFFENSE","DEFENSE"],"synergy_tags":["OFFENSE","DEFENSE"],"unlock_arena":2,"effects":[{"kind":"spawn","value":2,"target_type":"brute"}]},
        {"id":"earth_spikes","name":"Espinhos de Terra","rarity":"rare","category":"damage","energy_cost":3,"tags":["ARENA","DESTRUCTION"],"synergy_tags":["ARENA","DESTRUCTION","OFFENSE"],"unlock_arena":2,"effects":[{"kind":"damage","value":38,"area":120}]},
        {"id":"air_current","name":"Corrente de Ar","rarity":"common","category":"mobility","energy_cost":2,"tags":["MOBILITY","CONTROL"],"synergy_tags":["MOBILITY","CONTROL","PUSH"],"unlock_arena":1,"effects":[{"kind":"speed","value":0.5,"duration":3}]},
        {"id":"overload","name":"Sobrecarga","rarity":"rare","category":"damage","energy_cost":4,"tags":["ELEMENTAL","OFFENSE"],"synergy_tags":["ELEMENTAL","OFFENSE","ARENA"],"unlock_arena":3,"effects":[{"kind":"damage","value":48,"area":160}]},
        {"id":"shock_chain","name":"Corrente de Choque","rarity":"epic","category":"control","energy_cost":4,"tags":["ELEMENTAL","CONTROL"],"synergy_tags":["ELEMENTAL","CONTROL","OFFENSE"],"unlock_arena":3,"effects":[{"kind":"damage","value":42,"area":200}]}
    ]
