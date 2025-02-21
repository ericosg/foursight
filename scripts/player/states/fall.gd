extends State

@export var idle_state: State
@export var move_state: State

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta

	var movement: float = 0
	if Input.is_action_just_pressed("left"):
		movement = -Settings.Distance * delta
	elif Input.is_action_just_pressed("right"):
		movement = Settings.Distance * delta
	
	if movement != 0:
		parent.animations.flip_h = movement < 0
	
	# Dash instead
	#parent.velocity.x = movement
	parent.move_and_collide(Vector2(movement, 0))
	parent.move_and_slide()
	
	if parent.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	return null
