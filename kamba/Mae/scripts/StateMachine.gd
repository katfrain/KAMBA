class_name StateMachine
extends Node

@export var current_state: State
@export var animated_sprite: AnimatableBody2D: 
	get: 
		return $"../AnimatedSprite2D"


var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.state_machine = self
			if not child.transitioned.is_connected(on_child_transitioned):
				child.transitioned.connect(on_child_transitioned)
		else:
			push_warning("State machine contains child which is not 'State'")
			
	current_state.Enter()
			
func process(delta):
	current_state.Update(delta)
func physics_process(delta, can_move):
	current_state.Physics_update(delta, can_move)


func on_child_transitioned(new_state_name: StringName) -> void:
	var new_state = states.get(new_state_name)
	if new_state != null:
		if new_state != current_state:
			current_state.Exit()
			new_state.Enter()
			current_state = new_state
			current_state.state_machine = self
	else:
		push_warning("Called transition on a state that does not exist")

	

	
