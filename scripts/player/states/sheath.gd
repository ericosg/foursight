extends State

@export var fast_state: State
@export var hard_state: State

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('fast'):
		return fast_state
	if Input.is_action_just_pressed('hard'):
		return hard_state
	return null
