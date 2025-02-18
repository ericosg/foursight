extends State

func enter() -> void:
	super()
	if parent is Enemy:
		(parent as Enemy).collision.disabled = true

func _on_animations_animation_finished() -> void:
	parent.queue_free()
