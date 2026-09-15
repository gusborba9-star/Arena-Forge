class_name MatchProgression
extends RefCounted
var level := 1
var xp := 0
var xp_to_next := 40
func add_xp(amount: int) -> void:
    xp += maxi(0, amount)
    while xp >= xp_to_next:
        xp -= xp_to_next
        level += 1
        xp_to_next = 40 + (level - 1) * 20
