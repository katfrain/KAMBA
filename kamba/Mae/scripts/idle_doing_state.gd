#Idle Doing State
class_name IdleDoingState
extends State


@export var persona: State   # Dynamically updated persona identity
@export var animated_sprite: AnimatableBody2D: 
	get: 
		return $"../../KatAndMaeAnimations"
var local_can_move: bool = true

func Enter():
	persona = state_machine.persona_identity 
	animated_sprite.play(persona.GetName()+"Idle")
	entered.emit()
		
func UpdatePersona(identity: State):
	persona = identity
	animated_sprite.play(persona.GetName()+"Idle")
	pass

func Update(delta: float):
	if local_can_move:
		if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
			transitioned.emit("MoveDoingState")
		if Input.is_action_just_pressed("jump"):
			transitioned.emit("JumpDoingState")
			
func Physics_update(delta, can_move):
	if not can_move:
		local_can_move = false
	else:
		local_can_move = true
		
func Exit():
	pass
	
