extends Node2D

func _ready():
	Global.Frozen = false
	Global.CutScene = false

func _on_enemy_tree_exited() -> void:
	$Instructions.text = "You can also use a controller"
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/story.tscn")
	
