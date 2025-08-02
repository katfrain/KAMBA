extends State

signal debug_text_charge()
var player = null
@onready var charge_timer = $"../../Charge_Timer"
var ground_in_front: bool = true

func Enter() -> void:
	if charge_timer.is_stopped():
		debug_text_charge.emit()
		charge_timer.start(1.0)
	else:
		print("Charge timer already running — not restarting")

func Exit() -> void:
	pass
	
func charge_end():
	transitioned.emit("Attack")
	
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
	if ground_in_front:
		enemy.velocity.x = 10
	else:
		enemy.velocity.x = 0  
		
	enemy.move_and_slide()

func no_ground() -> void:
	ground_in_front = false

func ground() -> void:
	ground_in_front = true

func _on_charge_timeout() -> void:
	charge_end()
