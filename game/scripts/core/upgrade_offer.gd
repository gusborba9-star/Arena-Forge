class_name UpgradeOffer
extends RefCounted
var id := ""
var rarity := "common"
var effects: Dictionary = {}
func _init(new_id: String, new_rarity: String, new_effects: Dictionary) -> void:
    id = new_id
    rarity = new_rarity
    effects = new_effects.duplicate(true)
