extends State

@export var stopped_state: State

func animation_finished() -> State:
	parent.animations.speed_scale = Settings.FrozenSpeedScale
	return stopped_state
