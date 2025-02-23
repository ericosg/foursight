extends State

@export var fall_state: State
@export var idle_state: State
@export var move_state: State

func enter() -> void:
	if parent.can_show_movements:
		super()
	parent.pause()
	parent.velocity.y = -Settings.JumpForce
	
func exit() -> void:
	super()
	parent.play()

func process_physics(delta: float) -> State:
	parent.move()
	if parent.velocity.y > 0:
		return fall_state
	
	if parent.is_on_floor():
		return move_state
	
	return null
