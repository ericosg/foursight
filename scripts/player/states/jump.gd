extends MoveState

@export var fall_state: State
@export var idle_state: State
@export var move_state: State

func enter() -> void:
	super()
	parent.velocity.y = -Settings.JumpForce

func process_physics(delta: float) -> State:
	var movement := get_movement()
	
	if parent.velocity.y > 0:
		return fall_state
	
	if parent.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	
	move(movement, delta)
	return null
