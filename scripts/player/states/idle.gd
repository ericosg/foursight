extends State

@export var fall_state: State
@export var jump_state: State
@export var move_state: State

func enter() -> void:
	super()
	parent.velocity.x = 0
	parent.move_position = parent.position # In case there's pending movement that can't be made

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('up') and parent.is_on_floor():
		return jump_state
	if Input.get_axis('left', 'right'):
		return move_state
	return null

func process_physics(delta: float) -> State:
	if !parent.is_on_floor():
		return fall_state
	return null
