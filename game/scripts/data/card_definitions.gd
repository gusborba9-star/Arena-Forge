class_name CardDefinitions
extends RefCounted
static func initial() -> Array[Dictionary]:
    return [
        {"id":"ice_wall","name":"Muralha de Gelo","energy_cost":3,"effects":[{"kind":"tile","value":1}]},
        {"id":"wind_blast","name":"Rajada de Vento","energy_cost":2,"effects":[{"kind":"push","value":110,"area":170}]},
        {"id":"oil_pool","name":"Poça de Óleo","energy_cost":2,"effects":[{"kind":"tile","value":1}]},
        {"id":"spark_bomb","name":"Bomba de Faísca","energy_cost":3,"effects":[{"kind":"damage","value":28,"area":150}]},
        {"id":"healing_pillar","name":"Pilar de Cura","energy_cost":3,"effects":[{"kind":"heal","value":35}]},
        {"id":"water_geyser","name":"Gêiser","energy_cost":2,"effects":[{"kind":"push","value":70,"area":130}]},
        {"id":"blink","name":"Blink","energy_cost":2,"cooldown":5,"effects":[{"kind":"speed","value":1.0,"duration":1}]},
        {"id":"goblin_invasion","name":"Invasão Goblin","energy_cost":4,"effects":[{"kind":"spawn","value":4,"target_type":"goblin"}]},
        {"id":"meteor","name":"Meteoro","energy_cost":5,"effects":[{"kind":"damage","value":65,"area":190},{"kind":"push","value":90,"area":190},{"kind":"tile","value":1}]},
        {"id":"snowstorm","name":"Nevasca","energy_cost":4,"effects":[{"kind":"slow","value":0.5,"duration":4,"area":220}]},
        {"id":"black_hole","name":"Buraco Negro","energy_cost":5,"effects":[{"kind":"push","value":140,"area":220}]},
        {"id":"brute_invasion","name":"Invasão Bruta","energy_cost":5,"effects":[{"kind":"spawn","value":2,"target_type":"brute"}]},
        {"id":"earth_spikes","name":"Espinhos de Terra","energy_cost":3,"effects":[{"kind":"damage","value":38,"area":120}]},
        {"id":"air_current","name":"Corrente de Ar","energy_cost":2,"effects":[{"kind":"speed","value":0.5,"duration":3}]},
        {"id":"overload","name":"Sobrecarga","energy_cost":4,"effects":[{"kind":"damage","value":48,"area":160}]},
        {"id":"shock_chain","name":"Corrente de Choque","energy_cost":4,"effects":[{"kind":"damage","value":42,"area":200}]}
    ]
