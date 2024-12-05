#Jump Doing State
class_name JumpDoingState
extends State

@export var persona: State   # Dynamically updated persona identity

const JUMP = 400

@export var animated_sprite: AnimatableBody2D: 
	get: 
		return $"../../AnimatedSprite2D"

func Enter():
	state_machine.player.velocity.y = -JUMP
	print("in Jump")
	persona = state_machine.persona_identity 
	if state_machine.player.velocity.y == 0:
		transitioned.emit("IdleDoingState")

func _physics_process(delta: float) -> void:
	if state_machine.current_state == self:
		
		state_machine.player.velocity.y += gravity * delta
		state_machine.player.move_and_slide()
		
		if state_machine.player.is_on_floor(): 
			print("on floor")
			if state_machine.player.velocity.x != 0:
				transitioned.emit("MoveDoingState")
			transitioned.emit("IdleDoingState")

        if state_machine.player.velocity.y < 0:
			animated_sprite.play(persona.GetName()+"Up")
		if state_machine.player.velocity.y > 0:
			animated_sprite.play(persona.GetName()+"Down")
		


	
