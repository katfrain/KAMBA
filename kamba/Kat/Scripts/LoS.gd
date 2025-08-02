extends RayCast2D

var collision_detected: bool = false
var player
var player_position: Vector2
var in_range: bool = false
var checking: bool = false

signal initiate_chase
signal end_chase
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_range and player:
		player_position = player.global_position
		set_target_position((player_position - global_position))
		enabled = true
		if check_collider():
			if checking:
				initiate_chase.emit()
				checking = false
		if not check_collider() and not checking:
			end_chase.emit()
			checking = true
				


func _on_range_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		in_range = true
		checking = true
	
func check_collider() -> bool:
	if get_collider() == player:
		return true
	else:
		return false
		
#func _draw():
	#var end = target_position
	#draw_line(position, end, Color(1, 0, 0))


func _on_range_body_exited(body: Node2D) -> void:
	in_range = false
	enabled = false
	end_chase.emit()
