extends State

@export var sheath_state: State
@export var next_state: State

func enter() -> void:
	parent.can_move = false
	super()

func process_input(event: InputEvent) -> State:
	if next_state && Input.is_action_just_pressed('fast'):
		return next_state
	return null

func process_frame(delta: float) -> State:
	if parent.can_move:
		return sheath_state
	return null

func _on_animations_animation_finished() -> void:
	parent.can_move = true
