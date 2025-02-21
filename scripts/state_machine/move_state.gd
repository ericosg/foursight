class_name MoveState
extends State

var move_position: Vector2

func enter() -> void:
	super()
	move_position = parent.position 

func get_movement() -> float:
	var movement: float = 0
	if Input.is_action_just_pressed("left"):
		movement = -Settings.Distance
	elif Input.is_action_just_pressed("right"):
		movement = Settings.Distance
	return movement

func move(movement: float, delta: float) -> void:
	if movement != 0:
		parent.animations.flip_h = movement < 0
		move_position = parent.position 
		move_position.x += movement
	parent.velocity.x = parent.position.direction_to(move_position).x * Settings.Speed * delta
