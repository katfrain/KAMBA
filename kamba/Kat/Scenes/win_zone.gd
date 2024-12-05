extends Area2D

signal win

var win_con : bool = false

func set_win_con():
	print("setting win con to true")
	win_con = true
	
func check_win_con(body):
	print("checking win con...")
	print(win_con)
	if (win_con == true):
		win.emit()
