class_name Enemy
extends AnimatableBody2D

@onready var animations: AnimatedSprite2D = $animations
@onready var reactions := $reactions
@onready var collision := $collision

func _ready() -> void:
	reactions.init(self)
	
func die() -> void:
	reactions.change_state($reactions/dead)

func freeze() -> void:
	reactions.change_state($reactions/frozen)

func unfreeze() -> void:
	reactions.change_state($reactions/idle)


#func _process(delta: float) -> void:
	#if Global.Frozen:
		#modulate = Settings.FrozenColor
		#animations.speed_scale = Settings.FrozenSpeedScale
		#animations.play("Frozen")
	#else:
		#modulate = Settings.NormalColor
		#animations.speed_scale = Settings.NormalSpeedScale
		#animations.play("Idle")
