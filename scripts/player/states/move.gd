extends State

@export var fall_state: State
@export var idle_state: State
@export var jump_state: State

func enter() -> void:
	super()
	parent.pause()
	
func exit() -> void:
	super()
	parent.play()

func process_input(event: InputEvent) -> State:
	if event.is_action('up') and parent.is_on_floor():
		return jump_state
		
	return null

func process_physics(delta: float) -> State:
	parent.move()
	if parent.is_on_wall() or parent.velocity.x == 0:
		return idle_state
		
	if !parent.is_on_floor():
		return fall_state
	
	return null
