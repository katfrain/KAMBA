#Mae being State
class_name MaeBeingState
extends State

func Enter():
	entered.emit(self)
			
func Exit():
	print("mae state exited")
	
func GetName():
	return "Mae" 

func Update(delta):
	if Input.is_action_just_pressed("kat"):
		transitioned.emit("KatBeingState")

func Attack():
	print("im attacking")
	
