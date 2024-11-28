extends CharacterBody2D

var speed = 800.0
const JUMP_VELOCITY = -600.0
var direction
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

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	debug_text.text = str(velocity)
# flips sprite
func _process(delta: float) -> void:
	if (direction == -1) :
		$Sprite2D.flip_h = false
	elif (direction == 1):
		$Sprite2D.flip_h = true

# currently have the game paused upon win/loss, this could be changed in the future if something else fits our game better
# if collision shape enters killzone, check if its the player, if it is, game over
func fall_death(body: Node2D) -> void:
	if (body == self):
		game_over.emit()
		get_tree().paused = true

# if collision shape enters winzone, check if its the player, if it is, you win
func win(body: Node2D) -> void:
	if (body == self):
		win_level.emit()
		get_tree().paused = true
