class_name ContentCatalog
extends RefCounted

var heroes: Dictionary = {}
var cards: Dictionary = {}
var arenas: Dictionary = {}
var masteries: Dictionary = {}
var forges: Dictionary = {}
var forge_wars: Dictionary = {}
var war_arenas: Dictionary = {}
var war_rulesets: Dictionary = {}
var war_scoring_rulesets: Dictionary = {}
var war_contribution_rulesets: Dictionary = {}
var war_rewards: Dictionary = {}
var seasons: Dictionary = {}

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

func register_forge_war(value: Dictionary) -> void:
    var id := str(value.get("id", ""))
    if id != "":
        forge_wars[id] = value.duplicate(true)

func register_war_arena(value: Dictionary) -> void:
    var id := str(value.get("id", ""))
    if id != "":
        war_arenas[id] = value.duplicate(true)

func register_war_ruleset(value: Dictionary) -> void:
    var id := str(value.get("id", ""))
    if id != "":
        war_rulesets[id] = value.duplicate(true)

func register_war_scoring_ruleset(value: Dictionary) -> void:
    var id := str(value.get("id", ""))
    if id != "":
        war_scoring_rulesets[id] = value.duplicate(true)

func register_war_contribution_ruleset(value: Dictionary) -> void:
    var id := str(value.get("id", ""))
    if id != "":
        war_contribution_rulesets[id] = value.duplicate(true)

func register_war_rewards(value: Dictionary) -> void:
    var id := str(value.get("id", ""))
    if id != "":
        war_rewards[id] = value.duplicate(true)

func register_season(value: Dictionary) -> void:
    var id := str(value.get("id", ""))
    if id != "":
        seasons[id] = value.duplicate(true)

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
