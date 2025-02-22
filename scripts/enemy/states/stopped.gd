extends State

func animation_finished() -> State:
	parent.modulate = Settings.FrozenColor
	return null
