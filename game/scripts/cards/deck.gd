class_name ArenaDeck
extends RefCounted
const DECK_SIZE := 8
const HAND_SIZE := 4
var deck: Array[ArenaCard] = []
var hand: Array[ArenaCard] = []
var draw_index := 0
func set_deck(cards: Array[ArenaCard]) -> bool:
    if cards.size() != DECK_SIZE: return false
    deck = cards.duplicate()
    hand.clear()
    draw_index = 0
    for i in range(HAND_SIZE): hand.append(deck[i])
    draw_index = HAND_SIZE
    return true
func play(index: int) -> ArenaCard:
    if index < 0 or index >= hand.size(): return null
    var card: ArenaCard = hand[index]
    hand[index] = deck[draw_index % deck.size()]
    draw_index += 1
    return card
