extends Node2D

@onready var character_placeholder: CharacterBody2D = $Character/character_placeholder
signal start_timer
var coins = 0

func restart_level():
	get_tree().paused = false
	get_tree().reload_current_scene()
	character_placeholder.can_move = true
	start_timer.emit()
