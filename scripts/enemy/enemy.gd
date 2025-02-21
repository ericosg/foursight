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

func start() -> void:
	reactions.change_state($reactions/startup)
	
func _on_animations_animation_finished() -> void:
	match reactions.current_state.name:
		"dead":
			queue_free()
		"startup":
			reactions.change_state($reactions/stopped)
	
