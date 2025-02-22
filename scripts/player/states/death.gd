extends State

func enter() -> void:
	super()
	await (parent as Player).animations.animation_finished
	Global.Die()
