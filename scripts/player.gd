extends CharacterBody2D
class_name Player

var steps = []
var frozen = true

func _physics_process(delta: float) -> void:
	var me = $me

	if not is_on_floor():
		velocity += get_gravity() * delta

	if frozen:
		if is_on_floor():
			modulate = Settings.FrozenColor
		me.speed_scale = Settings.FrozenSpeedScale

		var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
		if steps.size() > 0 or direction != Vector2.ZERO:
			steps.push_back(direction)
	else:
		modulate = Settings.NormalColor
		me.speed_scale = Settings.NormalSpeedScale

		if steps.size() > 0:
			var current_direction: Vector2 = steps.pop_front()
			_move(delta, current_direction)
		if steps.size() == 0:
			frozen = true

	if Input.is_action_just_released("start") and steps.size() > 0:
		_trim_steps()
		frozen = false

	move_and_slide()

func _move(delta: float, direction: Vector2) -> void:
	if direction.y < 0 and is_on_floor():
		velocity.y = Settings.JumpVelocity * delta
	if direction.x != 0:
		velocity.x = direction.x * Settings.Speed * delta
	else:
		velocity.x = move_toward(velocity.x, 0, Settings.Speed * delta)

func _trim_steps() -> void:
	while steps.size() > 0 and steps[steps.size() - 1] == Vector2.ZERO:
		steps.pop_back()
	steps.push_back(Vector2.ZERO)
