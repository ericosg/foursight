extends State

func enter() -> void:
	super()
	parent.collision.disabled = true
	parent.hit_area.disabled = true
