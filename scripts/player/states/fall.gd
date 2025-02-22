extends State

@export var idle_state: State
@export var move_state: State

func enter() -> void:
	super()
	parent.pause()

func process_physics(delta: float) -> State:
	if parent.is_on_floor():
		return move_state
		
	parent.move(delta)
	return null
