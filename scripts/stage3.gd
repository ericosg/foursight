extends Node2D

func _ready():
	Global.Tutorial = false
	Global.CutScene = false

func _on_child_order_changed() -> void:
	var char_count := get_children().filter(func(n): return n is CharacterBody2D).size()
	if char_count == 1 and get_tree():
		get_tree().change_scene_to_file("res://scenes/end.tscn")
