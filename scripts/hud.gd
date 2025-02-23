extends Node2D

@export var can_count := true

func _process(delta):
	if can_count:
		Global.Seconds += delta
	$Seconds.text = str(snapped(Global.Seconds, 1))
	$Starts.text = str(Global.Starts)
	$Moves.text = str(Global.Moves)
