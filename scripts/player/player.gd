class_name Player
extends CharacterBody2D

@onready var animations: AnimatedSprite2D = $animations
@onready var movements = $movements
@onready var attacks = $attacks

var can_move := true

func _ready() -> void:
	movements.init(self)
	attacks.init(self)

func _unhandled_input(event: InputEvent) -> void:
	if can_move:
		movements.process_input(event)
	attacks.process_input(event)

func _physics_process(delta: float) -> void:
	if can_move:
		movements.process_physics(delta)
	attacks.process_physics(delta)

func _process(delta: float) -> void:
	if can_move:
		movements.process_frame(delta)
	attacks.process_frame(delta)
