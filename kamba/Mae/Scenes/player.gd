extends CharacterBody2D

@onready var Being_sm = $BeingStateMachine
@onready var Doing_sm = $DoingStateMachine
@onready var Marker = $Marker2D
@export var animated_sprite: AnimatableBody2D: 
	get: 
		return $AnimatedSprite2D
@export var arm: AnimatableBody2D: 
	get: 
		return $AnimatedSprite2D/Arm


var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_move: bool = true



signal game_over
signal win_level
var directionOfChar: bool = false

func _ready():
	pass
func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	
	velocity.y += gravity * delta
	if direction > 0:
		Marker.position.x = 20
		animated_sprite.flip_h = true
		arm.position.x = 320
		directionOfChar = true
				
	elif direction < 0:
		Marker.position.x = -48
		animated_sprite.flip_h = false
		arm.position.x = -320
		directionOfChar = false	
					
	Doing_sm.player.move_and_slide()
	Doing_sm.physics_process(delta, can_move)
		
	
	 
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Attack"):
		Being_sm.current_state.Attack()
	
	Being_sm.process(delta)
	Doing_sm.process(delta)
	
	
func fall_death(body: Node2D) -> void:
	game_over.emit()
	can_move = false

# if collision shape enters winzone, check if its the player, if it is, you win
func win():
	win_level.emit()
	can_move = false
	
func on_shoot(bullet):
	arm.play("Arm")
	var spawedBullet = bullet.instantiate() 
	if not spawedBullet: 
		print("Failed to instantiate bullet.") 
		return
	
	get_parent().add_child(spawedBullet)
	spawedBullet.position = Marker.global_position

	if directionOfChar:
		spawedBullet.vector = Vector2.RIGHT
	else: 	spawedBullet.vector = Vector2.LEFT
	
