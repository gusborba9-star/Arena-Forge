class_name MatchCommand
extends RefCounted

enum Type { INVALID, MOVE, PLAY_CARD, SELECT_UPGRADE }

var type := Type.INVALID
var direction := Vector2.ZERO
var index := -1

static func move(value: Vector2) -> MatchCommand:
    var command := MatchCommand.new()
    command.type = Type.MOVE
    command.direction = value
    return command

static func play_card(card_index: int) -> MatchCommand:
    var command := MatchCommand.new()
    command.type = Type.PLAY_CARD
    command.index = card_index
    return command

static func select_upgrade(upgrade_index: int) -> MatchCommand:
    var command := MatchCommand.new()
    command.type = Type.SELECT_UPGRADE
    command.index = upgrade_index
    return command

static func invalid() -> MatchCommand:
    return MatchCommand.new()
