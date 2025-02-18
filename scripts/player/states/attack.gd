extends State

@export var sheath_state: State
@export var fast_state: State
@export var hard_state: State

var next_state: State

func enter() -> void:
	next_state = null
	parent.can_move = false
	super()

func process_input(event: InputEvent) -> State:
	if fast_state && Input.is_action_just_pressed('fast'):
		next_state = fast_state
	if hard_state && Input.is_action_just_pressed('hard'):
		next_state = hard_state
	return null

func process_frame(delta: float) -> State:
	if parent.can_move:
		return next_state if next_state else sheath_state
	return null

func _on_animations_animation_finished() -> void:
	parent.can_move = true
