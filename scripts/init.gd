extends Node2D

func _ready():
	Global.Tutorial = true
	Global.CutScene = false

func _on_enemy_tree_exited() -> void:
	$Instructions.text = "You can also use a controller"
	if get_tree():
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://scenes/story.tscn")
