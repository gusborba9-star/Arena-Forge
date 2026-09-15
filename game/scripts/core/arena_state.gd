class_name ArenaState
extends RefCounted

enum Tile { NORMAL, WATER, ICE, FIRE, OIL, ELECTRIC, HAZARD, CRACKED, COLLAPSED, ABYSS }

var width := 12
var height := 7
var tiles: Array = []
var active_hazards: Array[Dictionary] = []

func _init() -> void:
    for y in range(height):
        var row: Array = []
        for x in range(width):
            row.append(Tile.NORMAL)
        tiles.append(row)

func set_tile(x: int, y: int, tile: Tile) -> void:
    if x >= 0 and x < width and y >= 0 and y < height:
        tiles[y][x] = tile

func get_tile(x: int, y: int) -> Tile:
    if x >= 0 and x < width and y >= 0 and y < height:
        return tiles[y][x]
    return Tile.ABYSS

func world_to_tile(position: Vector2) -> Vector2i:
    return Vector2i(clampi(int(floor((position.x - 40.0) / 100.0)), 0, width - 1), clampi(int(floor((position.y - 40.0) / 91.4286)), 0, height - 1))

func destroy_tile(x: int, y: int) -> Tile:
    var current := get_tile(x, y)
    var next := current
    match current:
        Tile.NORMAL:
            next = Tile.CRACKED
        Tile.CRACKED:
            next = Tile.COLLAPSED
        Tile.COLLAPSED:
            next = Tile.ABYSS
        Tile.ABYSS:
            next = Tile.ABYSS
        _:
            next = Tile.CRACKED
    set_tile(x, y, next)
    return next

func is_walkable(x: int, y: int) -> bool:
    return get_tile(x, y) not in [Tile.COLLAPSED, Tile.ABYSS]

func add_hazard(kind: String, value: float, duration: float) -> void:
    active_hazards.append({"kind": kind, "value": value, "remaining": maxf(0.0, duration)})

func tick(delta: float) -> void:
    for hazard in active_hazards:
        hazard["remaining"] = maxf(0.0, float(hazard["remaining"]) - delta)
    active_hazards = active_hazards.filter(func(h): return float(h["remaining"]) > 0.0)
