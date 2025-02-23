class_name Enemy
extends CharacterBody2D

@onready var animations: AnimatedSprite2D = $animations
@onready var reactions := $reactions
@onready var collision := $collision
@onready var area: Area2D = $area
@onready var hit_area := $area/hit

@export var auto_move := false

func _ready() -> void:
	Global.connect("FrozenChanged", freeze)
	reactions.init(self)
	
func freeze() -> void:
	reactions.process_input(null)
	
func die() -> void:
	reactions.change_state($reactions/dead)

func start() -> void:
	reactions.change_state($reactions/startup)
	
func _on_animations_animation_finished() -> void:
	reactions.animation_finished()
	
func _on_hit_body_entered(body: Node2D) -> void:
	if body is Player and not Global.CutScene:
		if auto_move:
			reactions.change_state($reactions/attack)
		else:
			reactions.change_state($reactions/react)
		
func _physics_process(delta: float) -> void:
	reactions.process_physics(delta)
