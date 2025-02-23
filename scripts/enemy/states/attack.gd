extends State

func enter() -> void:
	parent.modulate = Settings.NormalColor
	parent.animations.speed_scale = Settings.NormalSpeedScale
	super()
	if parent is Enemy:
		var area = (parent as Enemy).area
		if area.has_overlapping_bodies():
			var bodies := area.get_overlapping_bodies()
			for body in bodies:
				if body is Player:
					(body as Player).hit()
