extends State

@export var fall_state: State
@export var idle_state: State
@export var move_state: State

func enter() -> void:
	super()
	parent.pause()
	parent.velocity.y = -Settings.JumpForce

func process_physics(delta: float) -> State:
	if parent.velocity.y > 0:
		return fall_state
	
	if parent.is_on_floor():
		return move_state
	
	parent.move(delta)
	return null
