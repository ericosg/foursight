extends CharacterBody2D
class_name Player

var steps = []
var frozen = true

func _physics_process(delta):
	var me = $me
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if frozen:
		if is_on_floor():
			modulate = Settings.FrozenColor
		me.speed_scale = Settings.FrozenSpeedScale
		
		var direction = Input.get_vector("left", "right", "up", "down")
		if steps.size() > 0 or direction != Vector2.ZERO:
			steps.push_back(direction)
	else:
		modulate = Settings.NormalColor
		me.speed_scale = Settings.NormalSpeedScale
		
		if steps.size() > 0:
			var current_direction = steps.pop_front()
			_move(delta, current_direction)
		if steps.size() == 0:
			frozen = true
	
	if Input.is_action_just_released("start") and steps.size() > 0:
		frozen = false
	
	move_and_slide()

func _move(delta, direction):
	var vel = velocity
	if direction.y < 0 and is_on_floor():
		vel.y = Settings.JumpVelocity * delta
	if direction != Vector2.ZERO:
		vel.x = direction.x * Settings.Speed * delta
	else:
		vel.x = move_toward(velocity.x, 0, Settings.Speed * delta)
	velocity = vel
