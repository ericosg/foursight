extends State

@export
var fall_state: State
@export
var jump_state: State
@export
var move_state: State

func enter() -> void:
	super()
	parent.velocity.x = move_toward(parent.velocity.x, 0, Settings.Speed)

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('up') and parent.is_on_floor():
		return jump_state
	if Input.get_axis('left', 'right'):
		return move_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null
