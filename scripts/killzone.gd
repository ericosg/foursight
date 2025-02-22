extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if get_tree():
		await get_tree().create_timer(0.5).timeout
		Global.Die()
