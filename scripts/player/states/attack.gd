extends State

@export var sheath_state: State
@export var next_state: State

var can_next := false 

func enter() -> void:
	can_next = false
	parent.can_move = false
	super()

func process_input(event: InputEvent) -> State:
	if next_state && Input.is_action_just_pressed('fast'):
		can_next = true
	return null

func process_frame(delta: float) -> State:
	if parent.can_move:
		return next_state if can_next else sheath_state
	return null

func _on_animations_animation_finished() -> void:
	parent.can_move = true
