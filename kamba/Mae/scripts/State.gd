
class_name State
extends Node

signal transitioned(new_state_name: StringName)
signal entered(current_state_name: State)

var state_machine: StateMachine  # Reference to the state machine

@export
var move_speed: float = 400

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var parent: CharacterBody2D


#logic for when the state is first entered
func Enter() -> void:
	pass
	
#logic for when the state is ending 	
func Exit() -> void:
	pass
	
func process_input(event: InputEvent) -> State:
	return null	


func process_physics(delta: float):
	return null
	
#the logic being executed at each frame of the game	
func Update(delta: float) -> void:
	pass

#the logic at fixed physics intervals
func Physics_update(delta: float, can_move: bool) -> void:
	pass
