extends State

signal debug_text_idle

@export var animated_sprite: AnimatableBody2D: 
	get: 
		return $"../../AnimatedSprite2D"
		
func Enter() -> void:
	debug_text_idle.emit()
	animated_sprite.play("Enemy_Idle")
	
#logic for when the state is ending 	
func Exit() -> void:
	pass
	
func chase_start():

	transitioned.emit("Chase")
#the logic being executed at each frame of the game	
func Update(delta: float) -> void:
	pass

#the logic at fixed physics intervals
func Physics_update(delta: float, can_move: bool) -> void:
	state_machine.Enemy.velocity.x = 0
