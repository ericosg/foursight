extends Node2D

func _on_enemy_tree_exited() -> void:
	$Instructions.text = "You can also use a controller"
	$Timer.start()

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
