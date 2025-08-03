extends CharacterBody2D

@onready var Enemy: CharacterBody2D = $"."
@onready var state_machine: Node = $State_Machine
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_move: bool = true
var direction: bool = false # false = left, true = right
signal stop_chase_upon_death
var health: int = 3
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	set_direction(false)

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	state_machine.Enemy.move_and_slide()
	state_machine.physics_process(delta, can_move)
	if health == 0:
		animated_sprite_2d.play("Death")
	 
	
func _process(delta: float) -> void:
	state_machine.process(delta)
	state_machine.process(delta)


func game_over() -> void:
	stop_chase_upon_death.emit()
	
func get_direction() -> bool:
	return direction
	
func set_direction(new_direction: bool) -> void:
	direction = new_direction
	print('Facing right = ' + str(direction))
	



func _on_animated_sprite_2d_animation_looped() -> void:
	if animated_sprite_2d.animation == "Death":
			queue_free()


func _on_attack_range_area_entered(area: Area2D) -> void:
	if area.name == "KatBulletArea":
		health -=1
		print(health)
