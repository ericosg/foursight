extends State

@export var idle_state: State
@export var move_state: State

func process_input(event: InputEvent) -> State:
	if Global.IsFrozen():
		parent.modulate = Settings.FrozenColor
		parent.animations.speed_scale = Settings.FrozenSpeedScale
		return null
	else:
		parent.modulate = Settings.NormalColor
		parent.animations.speed_scale = Settings.NormalSpeedScale
		if parent.auto_move:
			return move_state
		else:
			return idle_state
