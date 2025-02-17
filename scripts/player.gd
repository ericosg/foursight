extends CharacterBody2D
class_name Player

@onready var _me = $four
var _steps = []

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Global.Frozen:
		if is_on_floor():
			modulate = Settings.FrozenColor
		_me.speed_scale = Settings.FrozenSpeedScale

		var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
		if _steps.size() > 0 or direction != Vector2.ZERO:
			_steps.push_back(direction)
	else:
		modulate = Settings.NormalColor
		_me.speed_scale = Settings.NormalSpeedScale

		if _steps.size() > 0:
			var current_direction: Vector2 = _steps.pop_front()
			_move(delta, current_direction)
		if _steps.size() == 0:
			Global.Frozen = true

	if Input.is_action_just_released("start") and _steps.size() > 0:
		_trim_steps()
		Global.Frozen = false

	move_and_slide()

func _move(delta: float, direction: Vector2) -> void:
	if direction.y < 0 and is_on_floor():
		velocity.y = Settings.JumpVelocity * delta
		_me.play("Walk")
	if direction.x != 0:
		velocity.x = direction.x * Settings.Speed * delta
		_me.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, Settings.Speed * delta)
		_me.play("Idle")

func _trim_steps() -> void:
	while _steps.size() > 0 and _steps[_steps.size() - 1] == Vector2.ZERO:
		_steps.pop_back()
	_steps.push_back(Vector2.ZERO)
