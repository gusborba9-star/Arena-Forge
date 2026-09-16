class_name ContentCatalog
extends RefCounted

var heroes: Dictionary = {}
var cards: Dictionary = {}
var arenas: Dictionary = {}
var masteries: Dictionary = {}
var forges: Dictionary = {}

func register_hero(value: Dictionary) -> void:
    var id := str(value.get("id", ""))
    if id != "":
        heroes[id] = value.duplicate(true)

func register_card(value: Dictionary) -> void:
    var id := str(value.get("id", ""))
    if id != "":
        cards[id] = value.duplicate(true)

func register_arena(value: Dictionary) -> void:
    var id := str(value.get("id", ""))
    if id != "":
        arenas[id] = value.duplicate(true)

func register_mastery(value: Dictionary) -> void:
    var id := str(value.get("id", ""))
    if id != "":
        masteries[id] = value.duplicate(true)

func register_forge(value: Dictionary) -> void:
    var id := str(value.get("id", ""))
    if id != "":
        forges[id] = value.duplicate(true)

func load_initial_content() -> void:
    for hero in HeroDefinitions.initial():
        register_hero(hero)
    for card in CardDefinitions.initial():
        register_card(card)
    for arena in ArenaDefinitions.initial():
        register_arena(arena)

func card_count() -> int:
    return cards.size()

func hero_count() -> int:
    return heroes.size()

func arena_count() -> int:
    return arenas.size()
