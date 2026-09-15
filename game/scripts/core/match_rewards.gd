class_name MatchRewards
extends RefCounted
static func calculate(elapsed: float, kills: int, level: int, survived: bool) -> Dictionary:
    var gold := 20 + kills * 3 + level * 2
    if survived: gold += 30
    return {"gold": gold, "fragments": maxi(1, int(floor(kills / 3.0)) + 1), "xp": int(elapsed * 0.5) + kills * 5}
