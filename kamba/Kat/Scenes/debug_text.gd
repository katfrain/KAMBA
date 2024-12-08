extends Label

func debug_text_idle() -> void:
	text = "IDLE"

func debug_text_move() -> void:
	text = "MOVE"

func debug_text_walk() -> void:
	text = "CHASE"
	
func debug_text_jump() -> void:
	text = "JUMP"
#func _process(delta: float) -> void:
	#text = str(enemy.velocity.x)
