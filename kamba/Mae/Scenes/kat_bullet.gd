extends CharacterBody2D

@export var speed = 600	
@export var vector = Vector2(1,0) 

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(delta*speed*vector)
	
