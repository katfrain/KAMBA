extends CharacterBody2D

@onready var Being_sm = $BeingStateMachine
@onready var Doing_sm = $DoingStateMachine
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	Doing_sm.player.move_and_slide()
	Doing_sm.physics_process(delta)
	
	 
func _process(delta: float) -> void:
	Being_sm.process(delta)
	Doing_sm.process(delta)
	
