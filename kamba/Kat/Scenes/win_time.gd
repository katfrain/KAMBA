extends Label

var time = 0.0

func replace_time():
	var timer = $"../../timer"
	time = timer.curTime
	text = "YOUR TIME: %.2fs" % time
