extends State

@export var fall_state: State
@export var idle_state: State
@export var jump_state: State

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('up') and parent.is_on_floor():
		return jump_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	var movement: float = 0
	if Input.is_action_just_pressed("left"):
		movement = -Settings.Distance * delta
	elif Input.is_action_just_pressed("right"):
		movement = Settings.Distance * delta
	
	if movement == 0:
		return idle_state
	
	parent.animations.flip_h = movement < 0
	
	# Dash instead
	#parent.velocity.x = movement
	parent.move_and_collide(Vector2(movement, 0))
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null
