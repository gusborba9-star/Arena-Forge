class_name MatchReadSnapshot
extends RefCounted

var _phase: int
var _elapsed: float
var _hero_id: String
var _hero_position: Vector2
var _hero_hp: float
var _hero_max_hp: float
var _hero_dead: bool
var _energy: float
var _level: int
var _kills: int
var _telegraph_active: bool
var _telegraph_id: String
var _telegraph_remaining: float
var _enemy_positions: Array[Vector2]
var _enemy_alive: Array[bool]
var _card_names: Array[String]
var _card_costs: Array[int]
var _pending_upgrade: bool
var _rewards: Dictionary

func _init(source: MatchRuntime, presentation_energy: float, card_hand: Array, presentation_pending_upgrade: bool) -> void:
    _phase = source.state.phase
    _elapsed = source.state.elapsed
    _hero_id = source.hero.id
    _hero_position = source.hero.position
    _hero_hp = source.hero.hp
    _hero_max_hp = source.hero.max_hp
    _hero_dead = source.hero.dead
    _energy = presentation_energy
    _level = source.progression.level
    _kills = source.kills
    _telegraph_active = source.telegraph.active
    _telegraph_id = source.telegraph.id
    _telegraph_remaining = source.telegraph.remaining
    _enemy_positions = []
    _enemy_alive = []
    for enemy: ArenaEnemy in source.enemies:
        _enemy_positions.append(enemy.position)
        _enemy_alive.append(not enemy.dead)
    _card_names = []
    _card_costs = []
    for card: ArenaCard in card_hand:
        _card_names.append(str(card.card_name))
        _card_costs.append(int(card.energy_cost))
    _pending_upgrade = presentation_pending_upgrade
    _rewards = source.result()

func phase() -> int: return _phase
func elapsed() -> float: return _elapsed
func hero_id() -> String: return _hero_id
func hero_position() -> Vector2: return _hero_position
func hero_hp() -> float: return _hero_hp
func hero_max_hp() -> float: return _hero_max_hp
func hero_dead() -> bool: return _hero_dead
func energy() -> float: return _energy
func level() -> int: return _level
func kills() -> int: return _kills
func telegraph_active() -> bool: return _telegraph_active
func telegraph_id() -> String: return _telegraph_id
func telegraph_remaining() -> float: return _telegraph_remaining
func enemy_positions() -> Array[Vector2]: return _enemy_positions.duplicate()
func enemy_alive() -> Array[bool]: return _enemy_alive.duplicate()
func card_names() -> Array[String]: return _card_names.duplicate()
func card_costs() -> Array[int]: return _card_costs.duplicate()
func pending_upgrade() -> bool: return _pending_upgrade
func rewards() -> Dictionary: return _rewards.duplicate(true)
