extends AnimatableBody2D

@onready var _me = $enemy

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	if Global.Frozen:
		modulate = Settings.FrozenColor
		_me.speed_scale = Settings.FrozenSpeedScale
		_me.play("Idle")
	else:
		modulate = Settings.NormalColor
		_me.speed_scale = Settings.NormalSpeedScale
		_me.play("Startup")
