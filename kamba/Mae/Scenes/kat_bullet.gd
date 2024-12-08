extends CharacterBody2D

var speed = 300
var vector = Vector2(1,0) 

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(delta*speed*vector)
