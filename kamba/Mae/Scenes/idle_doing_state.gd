#Idle Doing State
class_name IdleDoingState
extends State


@export var persona: State   # Dynamically updated persona identity

@export var animated_sprite: AnimatableBody2D: 
	get: 
		return $"../../AnimatedSprite2D"

func Enter():
	persona = state_machine.persona_identity 
	animated_sprite.play(persona.GetName()+"Idle")
	print("idle entered")
		
func UpdatePersona(identity: State):
	persona = identity
	animated_sprite.play(persona.GetName()+"Idle")
	pass

func Update(delta: float):
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		transitioned.emit("MoveDoingState")
	if Input.is_action_just_pressed("jump"):
		transitioned.emit("JumpDoingState")

func Exit():
	print("idle state exited")
	

#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		#transitioned.emit("MoveDoingState")
	#if Input.is_action_just_pressed("jump"):
		#transitioned.emit("JumpDoingState")
	
