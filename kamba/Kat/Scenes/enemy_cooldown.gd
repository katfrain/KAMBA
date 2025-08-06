extends State

signal debug_text_cooldown()
@onready var cooldown_timer = $"../../Cooldown_Timer"
var ground_in_front: bool = true

func Enter() -> void:
	if cooldown_timer.is_stopped():
		debug_text_cooldown.emit()
		cooldown_timer.start(2.0)
	else:
		print("Charge timer already running — not restarting")

func Exit() -> void:
	pass
	
func cooldown_end():
	transitioned.emit("Idle")
	
	#the logic at fixed physics intervals
func Physics_update(delta: float, can_move: bool) -> void:
	var enemy = state_machine.Enemy

	# Ensure the enemy exists
	if not enemy:
		print("Enemy is not assigned in state machine!")
		return

	# Apply gravity
	enemy.velocity.y += enemy.gravity * delta
	
	# Enemy moves backwards slightly while charging
	enemy.velocity.x = 0  
		
	enemy.move_and_slide()

func _on_cooldown_timer_timeout() -> void:
	cooldown_end()
