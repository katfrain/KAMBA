extends CharacterBody2D

@onready var Enemy: CharacterBody2D = $"."
@onready var state_machine: Node = $State_Machine
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_move: bool = true

signal stop_chase_upon_death

func _ready():
	pass
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	state_machine.Enemy.move_and_slide()
	state_machine.physics_process(delta, can_move)
	
	 
func _process(delta: float) -> void:
	state_machine.process(delta)
	state_machine.process(delta)


func game_over() -> void:
	stop_chase_upon_death.emit()
