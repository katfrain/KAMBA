extends Label

var health: int
@export var prefix_text : String

func _ready() -> void:
	pass

func update_health(new_health: int):
	health = new_health
	update_text()

func update_text():
	text = str(prefix_text, health)
