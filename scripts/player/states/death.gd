extends State

func enter() -> void:
	if get_tree():
		await get_tree().create_timer(1.5).timeout
		Global.Die()
