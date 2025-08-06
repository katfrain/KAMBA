#Kat Being State
class_name KatBeingState
extends State

signal Katshoot(bullet)

@export var animated_sprite: AnimatableBody2D: 
	get: 
		return $"../../KatAndMaeAnimations"

@export var KatPaintbrush: AnimatableBody2D: 
	get: 
		return $"../../KatAndMaeAnimations/KatPaintbrush"
@onready var mae_dance: AnimatedSprite2D = $"../../KatAndMaeAnimations/MaeDance"

const bulletPath = preload("res://Mae/Scenes/Kat_bullet.tscn")
var  canAttack = true

func Enter():
	KatPaintbrush.show()
	mae_dance.hide()
	entered.emit(self)
	
func Exit():
	pass

func GetName():
	return "Kat"

func Update(delta):
	if Input.is_action_just_pressed("mae"):
		transitioned.emit("MaeBeingState")
	
func Attack():
	if canAttack:
		Katshoot.emit(bulletPath)
		canAttack = false
	else:
		print("reloading")	
		KatPaintbrush.play("Default")


func _on_arm_animation_looped() -> void:
	KatPaintbrush.stop()
	canAttack = true

	
