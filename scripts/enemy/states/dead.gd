extends State

func enter() -> void:
	super()
	if parent is Enemy:
		(parent as Enemy).collision.disabled = true
