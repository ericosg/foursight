extends CharacterBody2D

@onready var _me = $four

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		_me.play("Jump")
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = Settings.JumpVelocity * delta
	if Input.is_action_just_pressed("slash"):
		_me.play("Attack")
	if Input.is_action_just_pressed("blast"):
		_me.play("AttackCombo")
	var direction := Input.get_axis("left", "right")
	if direction > 0:
		_me.flip_h = false
		_me.position.x = 39
	elif direction < 0:
		_me.flip_h = true
		_me.position.x = -26
	if direction:
		velocity.x = direction * Settings.Speed * delta
		if is_on_floor():
			_me.play("Run2")
	else:
		velocity.x = move_toward(velocity.x, 0, Settings.Speed * delta)
		if is_on_floor():
			_me.play("Idle")
	move_and_slide()
