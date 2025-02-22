extends State

@export var idle_state: State
@export var move_state: State

func enter() -> void:
	super()
	parent.pause()

func exit() -> void:
	super()
	parent.play()

func process_physics(delta: float) -> State:
	parent.move()
	if parent.is_on_floor():
		return move_state
		
	return null
