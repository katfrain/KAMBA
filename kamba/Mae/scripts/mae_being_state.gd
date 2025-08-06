#Mae being State
class_name MaeBeingState
extends State

@export var animated_sprite: AnimatableBody2D: 
	get: 
		return $"../../KatAndMaeAnimations"
@export var KatPaintbrush: AnimatableBody2D: 
	get: 
		return $"../../KatAndMaeAnimations/KatPaintbrush"
@onready var mae_dance: AnimatedSprite2D = $"../../KatAndMaeAnimations/MaeDance"


var can_attack = true
var isDamage = false
var wait_time = 2

func Enter():
	KatPaintbrush.hide()
	mae_dance.hide()
	entered.emit(self)
			
func Exit():
	pass
	
func GetName():
	return "Mae" 

func Update(delta):
	if Input.is_action_just_pressed("kat"):
		transitioned.emit("KatBeingState")

func Attack():
	if can_attack:
		can_attack = false
		isDamage = true
		mae_dance.show()
		mae_dance.play("Dancing")
		print("mae is attacking")
		

func _on_mae_dance_animation_finished() -> void:
	if mae_dance.animation == "Dancing":
		isDamage = false
		mae_dance.play("Resting")
		print("is resting")
	else:
		mae_dance.hide()
		can_attack = true
		print("can dance again")
