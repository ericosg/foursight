extends Attack

@onready var collision = $"../../area/hard"

func enter() -> void:
	super()
	parent.pause()
	#parent.move_position = parent.position # Blast absorbs all current momentum
	collision.position.x = -37 if parent.animations.flip_h else 50 # Hack to flip collider
	collision.disabled = false # Collision detects for hard attacks

func exit() -> void:
	super()
	parent.play()
	destroy_enemies()
	collision.disabled = true
	#parent.position.x += -68 if parent.animations.flip_h else 68 # Sprite movement approx 68px
	#parent.move_position = parent.position # Blast absorbs all current momentum
