extends State

@export var fall_state: State
@export var jump_state: State
@export var move_state: State

func enter() -> void:
	if parent.can_show_movements:
		super()
	parent.stop()
	if not parent.has_steps():
		Global.Freeze()

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
