extends Label

func debug_text_idle() -> void:
	text = "IDLE"

func debug_text_move() -> void:
	text = "MOVE"

func debug_text_walk() -> void:
	text = "CHASE"
	
func debug_text_jump() -> void:
	text = "JUMP"

func debug_text_charge() -> void:
	text = "CHARGE"
	
func debug_text_attack() -> void:
	text = "ATTACK"
	
func debug_text_cooldown() -> void:
	text = "COOLDOWN"
#func _process(delta: float) -> void:
	#text = str(enemy.velocity.x)
