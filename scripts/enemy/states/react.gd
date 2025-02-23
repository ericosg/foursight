extends State

@export var attack_state: State

func enter() -> void:
	parent.modulate = Settings.FastColor
	parent.animations.speed_scale = Settings.FastSpeedScale
	super()

func animation_finished() -> State:
	parent.modulate = Settings.NormalColor
	parent.animations.speed_scale = Settings.NormalSpeedScale
	return attack_state
