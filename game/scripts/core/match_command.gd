class_name MatchCommand
extends RefCounted

enum Type { INVALID, MOVE }

var type := Type.INVALID
var direction := Vector2.ZERO

static func move(value: Vector2) -> MatchCommand:
    var command := MatchCommand.new()
    command.type = Type.MOVE
    command.direction = value
    return command

static func invalid() -> MatchCommand:
    return MatchCommand.new()
