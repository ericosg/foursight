extends State

@export var fast_state: State
@export var hard_state: State

func enter() -> void:
	super()

func process_input(event: InputEvent) -> State:
	if event.is_action('fast'):
		return fast_state
	if event.is_action('hard'):
		return hard_state
	return null
