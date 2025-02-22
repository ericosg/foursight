class_name Enemy
extends AnimatableBody2D

@onready var animations: AnimatedSprite2D = $animations
@onready var reactions := $reactions
@onready var collision := $collision
@onready var hit_area := $hit/area

func _ready() -> void:
	Global.connect("FrozenChanged", freeze)
	reactions.init(self)
	
func freeze() -> void:
	if Global.IsFrozen():
		modulate = Settings.FrozenColor
		animations.speed_scale = Settings.FrozenSpeedScale
		reactions.change_state($reactions/frozen)
	else:
		modulate = Settings.NormalColor
		animations.speed_scale = Settings.NormalSpeedScale
		reactions.change_state($reactions/idle)
	
func die() -> void:
	reactions.change_state($reactions/dead)

func start() -> void:
	reactions.change_state($reactions/startup)
	
func _on_animations_animation_finished() -> void:
	match reactions.current_state.name:
		"dead":
			queue_free()
		"startup":
			animations.speed_scale = Settings.FrozenSpeedScale
			reactions.change_state($reactions/stopped)
		"stopped":
			modulate = Settings.FrozenColor
	
func _on_hit_body_entered(body: Node2D) -> void:
	if body is Player and not Global.CutScene:
		modulate = Settings.NormalColor
		animations.speed_scale = Settings.NormalSpeedScale
		reactions.change_state($reactions/attack)
		(body as Player).hit()
		
