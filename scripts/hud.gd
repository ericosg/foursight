extends Node2D

func _process(delta):
	Global.Seconds += delta
	$Seconds.text = str(snapped(Global.Seconds, 1))
	$Starts.text = str(Global.Starts)
	$Moves.text = str(Global.Moves)
