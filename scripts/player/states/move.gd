extends State

@export var fall_state: State
@export var idle_state: State
@export var jump_state: State

func process_input(event: InputEvent) -> State:
	if event.is_action('up') and parent.is_on_floor():
		return jump_state
	return null

func process_physics(delta: float) -> State:
	if parent.is_on_wall() or parent.position.distance_to(parent.move_position) < 2:
		return idle_state
		
	if !parent.is_on_floor():
		return fall_state
	
	parent.move(delta)
	return null
