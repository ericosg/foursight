extends MoveState

@export var fall_state: State
@export var idle_state: State
@export var jump_state: State

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('up') and parent.is_on_floor():
		return jump_state
	return null

func process_physics(delta: float) -> State:
	var movement := get_movement()
	
	if movement == 0 and parent.position.distance_to(move_position) < 2:
		return idle_state
		
	if !parent.is_on_floor():
		return fall_state
	
	move(movement, delta)
	return null
