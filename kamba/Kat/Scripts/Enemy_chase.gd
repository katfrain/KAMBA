extends State

# Martys contribution: hjyyyyyyyyyygnjmhhhhhhhhhhhhhhhhhhhhhh

signal debug_text_walk
var run_speed = 100
var player = null
var ground_in_front: bool = true
var active: bool = false
@onready var enemy = $"../.."

@export var animated_sprite: AnimatableBody2D: 
	get: 
		return $"../../AnimatedSprite2D"
		
func Enter() -> void:
	debug_text_walk.emit()
	animated_sprite.play("Enemy_Walk")
	active = true
	
#logic for when the state is ending 	
func Exit() -> void:
	active = false
	
func chase_end():
	transitioned.emit("Idle")
#the logic being executed at each frame of the game	
func Update(delta: float) -> void:
	pass
	
func charge_start():
	transitioned.emit("Charge")

#the logic at fixed physics intervals
func Physics_update(delta: float, can_move: bool) -> void:
	var enemy = state_machine.Enemy

	# Ensure the enemy exists
	if not enemy:
		print("Enemy is not assigned in state machine!")
		return

	# Apply gravity
	enemy.velocity.y += enemy.gravity * delta

	# Movement logic
	if player:
		var direction = enemy.position.direction_to(player.position)
		var new_direction: bool = direction.x >= 0

		# If enemy switches directions, seitch enemies direction booleam
		if new_direction != enemy.get_direction():
			enemy.set_direction(new_direction)

		# Check if there's ground in front
		if ground_in_front:
			enemy.velocity.x = direction.x * run_speed  # Move toward player
		else:
			enemy.velocity.x = 0  # Stop moving to avoid falling off

		# Flip the sprite based on movement direction
		if direction.x < 0:
			animated_sprite.flip_h = false  # Facing right
		elif direction.x > 0:
			animated_sprite.flip_h = true   # Facing left

	# Move the enemy using the updated velocity
	enemy.move_and_slide()



func _on_range_body_entered(body: Node2D) -> void:
	player = body


func _on_range_body_exited(body: Node2D) -> void:
	player = null

func _on_range_body_entered_attack_range(body: Node2D) -> void:
	if active == true:
		print('calling charge start')
		charge_start()

func no_ground() -> void:
	ground_in_front = false


func ground() -> void:
	ground_in_front = true
