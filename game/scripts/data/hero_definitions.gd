class_name HeroDefinitions
extends RefCounted

static func initial() -> Array[Dictionary]:
    return [
        {"id":"giant","role":"tank","hp":210.0,"damage":18.0,"speed":170.0,"armor":3.0,"attack_range":70.0,"ability_id":"giant_guard","tags":["DEFENSE","MELEE"],"mastery_id":"giant_mastery","specialization_id":"giant_specialization"},
        {"id":"mage","role":"elemental","hp":100.0,"damage":22.0,"speed":240.0,"armor":0.0,"attack_range":260.0,"ability_id":"elemental_burst","tags":["ELEMENTAL","RANGED","OFFENSE"],"mastery_id":"mage_mastery","specialization_id":"mage_specialization"},
        {"id":"elf","role":"ranged_mobility","hp":120.0,"damage":14.0,"speed":260.0,"armor":0.0,"attack_range":300.0,"ability_id":"quickstep","tags":["RANGED","MOBILITY","NATURE"],"mastery_id":"elf_mastery","specialization_id":"elf_specialization"},
        {"id":"warrior","role":"fighter","hp":155.0,"damage":20.0,"speed":220.0,"armor":1.0,"attack_range":90.0,"ability_id":"battle_rush","tags":["OFFENSE","DEFENSE","MELEE"],"mastery_id":"warrior_mastery","specialization_id":"warrior_specialization"}
    ]
