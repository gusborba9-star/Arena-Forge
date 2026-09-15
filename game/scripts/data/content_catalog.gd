class_name ContentCatalog
extends RefCounted
var heroes := {}
var cards := {}
var arenas := {}
func register_hero(value: Dictionary) -> void: heroes[value.id] = value
func register_card(value: Dictionary) -> void: cards[value.id] = value
func register_arena(value: Dictionary) -> void: arenas[value.id] = value
