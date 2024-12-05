class_name StateMachine
extends Node

@export var current_state: State
@export var persona_identity: State   # Dynamically updated persona identity
@onready var player: CharacterBody2D = $".."
@export var animated_sprite: AnimatableBody2D: 
	get: 
		return $"../AnimatedSprite2D"


var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.state_machine = self
			
		else:
			push_warning("State machine contains child which is not 'State'")
			
	current_state.Enter()
			
func _process(delta):
	current_state.Update(delta)


func _on_persona_entered(identity: State):	
	persona_identity = identity
	animated_sprite.play("Poof")
		
func Poof_Done():
	if animated_sprite.animation == "Poof":	
		current_state.UpdatePersona(persona_identity)
	

func _physics_process(delta):
	current_state.Physics_update(delta)
	
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
