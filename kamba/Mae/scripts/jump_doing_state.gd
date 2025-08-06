#Jump Doing State
class_name JumpDoingState
extends State

@export var persona: State   # Dynamically updated persona identity

const JUMP = 600

@export var animated_sprite: AnimatableBody2D: 
	get: 
		return $"../../KatAndMaeAnimations"

func Enter():
	state_machine.player.velocity.y = -JUMP
	persona = state_machine.persona_identity 
	animated_sprite.play(persona.GetName() + "Up")
	entered.emit()

func UpdatePersona(identity: State):
	persona = identity
	animated_sprite.play(persona.GetName()+"Jump")

func Physics_update(delta, can_move):
	
		animated_sprite.play(persona.GetName() + "Up")
		var direction = Input.get_axis('move_left', 'move_right') 
		var movement = direction * move_speed

		#if direction > 0: 
			#animated_sprite.flip_h = true 
		#elif direction < 0: 
			#animated_sprite.flip_h = false
		#
		state_machine.player.velocity.x = movement
		#state_machine.player.move_and_slide()
		
	
		if state_machine.player.is_on_floor(): 
			if state_machine.player.velocity.x != 0:
				transitioned.emit("MoveDoingState")
			else:
				transitioned.emit("IdleDoingState")
