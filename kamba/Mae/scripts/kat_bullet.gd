extends CharacterBody2D

@export var speed = 600	
@export var vector = Vector2(1,0) 
@onready var bullet_animation: AnimatedSprite2D = $BulletAnimation
@onready var player: CharacterBody2D = $"."
@onready var enemy: CharacterBody2D = $"."


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(delta*speed*vector)
	


func _on_area_2d_area_entered(area: Area2D) -> void:
		print(area.name)
		if area.name != "Enemy_Kill_Zone":
			bullet_animation.play("Exploads")
		
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name != "Player":
		bullet_animation.play("Exploads")
		
	
func _on_bullet_animation_animation_looped() -> void:
	if bullet_animation.animation  == "Exploads":
		queue_free()
	
	
