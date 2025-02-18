extends Attack

func exit() -> void:
	parent.position.x += -64 if parent.animations.flip_h else 64 # Sprite movement approx 64px
	destroy_enemies() # TODO: Blast still has an issue killing enemies
