extends CharacterBody2D

@onready var Being_sm = $BeingStateMachine
@onready var Doing_sm = $DoingStateMachine
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	Being_sm._ready()
	Doing_sm._ready()
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
		
