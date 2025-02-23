extends State

@export var frozen_state: State
@export var idle_state: State

var direction := 1

func process_input(event: InputEvent) -> State:
	if Global.IsFrozen():
		parent.modulate = Settings.FrozenColor
		parent.animations.speed_scale = Settings.FrozenSpeedScale
		return frozen_state
	else:
		parent.modulate = Settings.NormalColor
		parent.animations.speed_scale = Settings.NormalSpeedScale
		if parent.auto_move:
			return null
		else:
			return idle_state

func process_physics(delta: float) -> State:
	if parent.auto_move and not Global.IsFrozen():
		parent.velocity += parent.get_gravity() * delta
		parent.velocity.x = direction * Settings.Speed
		parent.move_and_slide()
		if parent.is_on_wall():
			direction *= -1
			parent.animations.flip_h = direction < 0
	return null
