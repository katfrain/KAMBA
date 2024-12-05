extends Label

var coin_count = 0
@export var coins_needed : int
@export var prefix_text : String

signal coins_needed_reached

func _ready() -> void:
	update_text()

func update_coin_count(body):
	coin_count += 1
	update_text()
	if (coin_count == coins_needed):
		coins_needed_reached.emit()
		
func update_text():
	text = str(prefix_text, coin_count, "/", coins_needed)
