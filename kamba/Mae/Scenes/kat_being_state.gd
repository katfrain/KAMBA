#Kat Being State
class_name KatBeingState
extends State

signal Katshoot(bullet)

@export var animated_sprite: AnimatableBody2D: 
	get: 
		return $"../../AnimatedSprite2D"

@export var arm: AnimatableBody2D: 
	get: 
		return $"../../AnimatedSprite2D/Arm"

const bulletPath = preload("res://Mae/Scenes/Kat_bullet.tscn")


func Enter():
	entered.emit(self)
	
func Exit():
	print("kat state exited")

func GetName():
	return "Kat"

func Update(delta):
	if Input.is_action_just_pressed("mae"):
		transitioned.emit("MaeBeingState")
	
func Attack():
	Katshoot.emit(bulletPath)
	
