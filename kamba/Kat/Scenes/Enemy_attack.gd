extends State

signal debug_text_attack
var attack_distance = 300
var run_speed = 200
var ground_in_front: bool = true
var direction: int = -1

func Enter() -> void:
	var enemy = state_machine.Enemy
	print("Entered attack state")
	debug_text_attack.emit()
	if enemy.get_direction() == false:
		direction = -1
	else:
		direction = 1
		

func Exit() -> void:
	print("Exited attack state")
	pass

func Physics_update(delta: float, can_move: bool) -> void:
	var enemy = state_machine.Enemy

	# Ensure the enemy exists
	if not enemy:
		print("Enemy is not assigned in state machine!")
		return

	# Apply gravity
	enemy.velocity.y += enemy.gravity * delta

	# Movement logic
	# Check if there's ground in front
	if ground_in_front:
		enemy.velocity.x = direction * run_speed
	else:
		enemy.velocity.x = 0


	# Move the enemy using the updated velocity
	enemy.move_and_slide()

func no_ground() -> void:
	ground_in_front = false


func ground() -> void:
	ground_in_front = true
