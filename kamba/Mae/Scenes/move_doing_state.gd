#move Doing State
class_name MoveDoingState
extends State

const SPEED = 800.0
const JUMP = 400

var movement
var direction = 0


@export var persona: State   # Dynamically updated persona identity

@export var animated_sprite: AnimatableBody2D: 
	get: 
		return $"../../AnimatedSprite2D"


func Enter():
	persona = state_machine.persona_identity
	animated_sprite.play(persona.GetName() + "Move")
	entered.emit()
	
func UpdatePersona(identity: State):
	persona = identity
	animated_sprite.play(persona.GetName()+"Move")
	pass	

func Physics_update(delta, can_move):
	state_machine.player.velocity.y += gravity * delta

	if can_move:
		# Process movement input only if can_move is true
		
		var direction = Input.get_axis("move_left", "move_right")
		
		# Play animations based on input
		if Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right"):
			animated_sprite.play(persona.GetName() + "Idle")
		else:
			animated_sprite.play(persona.GetName() + "Move")

		# Update velocity based on input
		if direction != 0:
			state_machine.player.velocity.x = direction * move_speed
		else:
			state_machine.player.velocity.x = move_toward(state_machine.player.velocity.x, 0, move_speed)

		# Flip sprite based on movement direction
		if direction > 0:
			animated_sprite.flip_h = true
		elif direction < 0:
			animated_sprite.flip_h = false

	else:
		# Stop all movement when can_move is false
		state_machine.player.velocity.x = 0
		animated_sprite.play(persona.GetName() + "Idle")

	# Transitioning states
	if state_machine.player.velocity.x == 0 and not Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		transitioned.emit("IdleDoingState")
	if Input.is_action_just_pressed("jump") and can_move:
		transitioned.emit("JumpDoingState")

		
#
#func _physics_process(delta: float) -> void:
	#if state_machine.current_state == self:
		#
		#state_machine.player.velocity.y += gravity * delta
		#
		#var direction = Input.get_axis('move_left', 'move_right') 
		#var movement = direction * move_speed
#
		#
		#if direction > 0: 
			#animated_sprite.flip_h = true 
		#elif direction < 0: 
			#animated_sprite.flip_h = false
		#
		#state_machine.player.velocity.x = movement
		#state_machine.player.move_and_slide()
		#
		##transitioning states
		#if movement == 0:
			#transitioned.emit("IdleDoingState")
		#if Input.is_action_just_pressed("jump"):
				#transitioned.emit("JumpDoingState")
			#
			#

func Exit():
	pass
