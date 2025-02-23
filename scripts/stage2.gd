extends Node2D

func _ready():
	Global.CutScene = false

func _on_child_order_changed() -> void:
	var enemy_count := get_children().filter(func(n): return n is CharacterBody2D).size()
	if enemy_count == 0 and get_tree():
		get_tree().change_scene_to_file("res://scenes/stage3.tscn")
