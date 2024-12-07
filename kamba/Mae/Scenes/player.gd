extends CharacterBody2D

@onready var Being_sm = $BeingStateMachine
@onready var Doing_sm = $DoingStateMachine
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_move: bool = true

signal game_over
signal win_level

func _ready():
	pass
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	Doing_sm.player.move_and_slide()
	Doing_sm.physics_process(delta)
	
	 
func _process(delta: float) -> void:
	Being_sm.process(delta)
	Doing_sm.process(delta)
	
	
func fall_death(body: Node2D) -> void:
	game_over.emit()
	can_move = false

# if collision shape enters winzone, check if its the player, if it is, you win
func win():
	win_level.emit()
	can_move = false
