extends Label

var curTime = 0
var active : bool = true

func _ready():
	curTime = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		curTime += delta
		text = "Time: %.2fs" % curTime

func stop_timer():
	active = false
	
func start_timer():
	active = true
