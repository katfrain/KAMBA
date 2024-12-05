#Kat Being State
class_name KatBeingState
extends State

func Enter():
	entered.emit(self)
	
func Exit():
	print("kat state exited")

func GetName():
	return "Kat"


func _process(delta):
	if Input.is_action_just_pressed("mae"):
		transitioned.emit("MaeBeingState")
	
