extends Label

var curTime = 0

func _ready():
	curTime = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	curTime += delta
	text = "Time: %.2fs" % curTime
