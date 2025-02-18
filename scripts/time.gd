extends Label

var time = 0

func _process(delta):
	time += delta
	text = str(snapped(time, 0.01))
