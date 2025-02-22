extends State

func enter() -> void:
	super()
	parent.collision.disabled = true
	parent.hit_area.disabled = true
	parent.animations.speed_scale = Settings.NormalSpeedScale

func animation_finished() -> State:
	parent.queue_free()
	return null
