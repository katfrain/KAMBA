extends CharacterBody2D

@onready var Enemy: CharacterBody2D = $"."
@onready var state_machine: Node = $State_Machine

@export var damage_amt = 20

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_move: bool = true
var direction: bool = false # false = left, true = right
signal stop_chase_upon_death
signal damage_player(damage_amt: int)

func _ready():
	set_direction(false)
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	state_machine.Enemy.move_and_slide()
	state_machine.physics_process(delta, can_move)
	
	 
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
	
func attack_player() -> void:
	print('In enemy, attempting to signal player')
	damage_player.emit(damage_amt)
	
	
	
