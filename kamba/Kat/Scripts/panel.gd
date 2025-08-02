extends Panel

func _ready() -> void:
	make_hidden()

func make_hidden():
	visible = false
	
func make_visible():
	visible = true
