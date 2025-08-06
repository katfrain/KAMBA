extends State

signal debug_text_attack
signal player_hit()

var attack_distance = 5
var run_speed = 200
var ground_in_front: bool = true
var direction: int = -1
var attacked_player: bool = false
var player = null

func Enter() -> void:
	var enemy = state_machine.Enemy
	debug_text_attack.emit()
	if enemy.get_direction() == false:
		direction = -1
	else:
		direction = 1
	attacked_player = false
		

func Exit() -> void:
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
		
	if attack_distance >= 0:
		attack_distance -= delta
	else:
		transitioned.emit("CoolDown")

	if player:
		hit_player()

	# Move the enemy using the updated velocity
	enemy.move_and_slide()

func hit_player() -> void:
	if attacked_player == false:
		attack_player()

func attack_player() -> void:
	print("attempting to attack player!")
	player_hit.emit()
	attacked_player = true

func no_ground() -> void:
	ground_in_front = false

func ground() -> void:
	ground_in_front = true

func _on_hit_box_body_entered(body: Node2D) -> void:
	print('Player entered hit box')
	player = body

func _on_hit_box_body_exited(body: Node2D) -> void:
	print('Player exited hit box')
	player = null
