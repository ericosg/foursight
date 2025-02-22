extends State

@export var fall_state: State
@export var jump_state: State
@export var move_state: State

func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.move_position = parent.position # In case there's pending movement that can't be made

func process_input(event: InputEvent) -> State:
	if event.is_action('up') and parent.is_on_floor():
		return jump_state
		
	if event.is_action("left") or event.is_action("right"):
		return move_state
		
	return null

func process_physics(delta: float) -> State:
	if !parent.is_on_floor():
		return fall_state
	return null
