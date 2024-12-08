extends Area2D

signal win

var win_con : bool = false

func set_win_con():
	win_con = true
	
func check_win_con(body):
	if (win_con == true):
		win.emit()
