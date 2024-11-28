extends Node2D

func restart_level():
	get_tree().paused = false
	get_tree().reload_current_scene()
