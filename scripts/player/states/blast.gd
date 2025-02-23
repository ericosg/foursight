extends Attack

@onready var hard_collision = $"../../area/hard"

func enter() -> void:
	super()
	#parent.move_position = parent.position # Blast absorbs all current momentum
	hard_collision.position.x = -37 if parent.animations.flip_h else 50 # Hack to flip collider
	hard_collision.disabled = false # Collision detects for hard attacks

func exit() -> void:
	super()
	hard_collision.disabled = true
	#parent.position.x += -68 if parent.animations.flip_h else 68 # Sprite movement approx 68px
	#parent.move_position = parent.position # Blast absorbs all current momentum
