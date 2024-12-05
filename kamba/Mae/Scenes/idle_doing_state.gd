#Idle Doing State
class_name IdleDoingState
extends State


@export var persona: State   # Dynamically updated persona identity

@export var animated_sprite: AnimatableBody2D: 
	get: 
		return $"../../AnimatedSprite2D"

func Enter():
	print("in idle state")
	persona = state_machine.persona_identity 
	animated_sprite.play(persona.GetName()+"Idle")
	

	
func UpdatePersona(identity: State):
	persona = identity
	animated_sprite.play(persona.GetName()+"Idle")
	pass


func Exit():
	print("idle state exited")

	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		transitioned.emit("MoveDoingState")
	if Input.is_action_just_pressed("jump"):
		transitioned.emit("JumpDoingState")
	
