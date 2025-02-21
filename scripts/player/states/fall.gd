extends State

@export var idle_state: State
@export var move_state: State

func process_physics(delta: float) -> State:
	var movement = parent.get_movement()
	
	if parent.is_on_floor():
		return move_state
		
	parent.move(movement, delta)
	return null
