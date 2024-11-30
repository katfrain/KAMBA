extends CharacterBody2D

const JUMP_VELOCITY = -600.0

var speed = 800.0
var direction = 0
var can_move: bool = true

@onready var debug_text: Label = $debug_text

signal game_over
signal win_level

# default movement script
func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		speed = 700
	else:
		speed = 800
	if (velocity.y >= 0):
		velocity += get_gravity() * delta * 2
		
	# Handle jump (only when can_move is true).
	if can_move and Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle movement/deceleration.
	# Horizontal movement stops if can_move is false.
	if can_move:
		direction = Input.get_axis("ui_left", "ui_right")
	else:
		direction = 0  # Force no horizontal input
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	move_and_slide()
	debug_text.text = str(velocity)

# runs every frame
func _process(delta: float) -> void:
	# flips sprite
	if (direction == -1) :
		$Sprite2D.flip_h = false
	elif (direction == 1):
		$Sprite2D.flip_h = true

# if collision shape enters killzone, check if its the player, if it is, game over
func fall_death(body: Node2D) -> void:
	game_over.emit()
	can_move = false

# if collision shape enters winzone, check if its the player, if it is, you win
func win():
	win_level.emit()
	can_move = false
