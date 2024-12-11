extends RayCast2D

var on_ground: bool = true


signal no_ground
signal ground

func _process(delta: float) -> void:
	if is_colliding() and not on_ground:
		ground.emit()
		on_ground = true
	elif not is_colliding() and on_ground:
		no_ground.emit()
		on_ground = false
		
