class_name Player
extends CharacterBody2D

@onready var animations: AnimatedSprite2D = $animations
@onready var area: Area2D = $area
@onready var movements = $movements
@onready var attacks = $attacks

var can_move := true
var move_position: Vector2
var _steps: Array[InputEvent] = []
var _can_play_steps := false

func _ready() -> void:
	move_position = position
	movements.init(self)
	attacks.init(self)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("start"):
		_can_play_steps = true
		return
		
	if Helper.is_handled(event):
		if Global.Frozen:
			_steps.push_back(event)
		elif not Global.CutScene:
			if can_move:
				movements.process_input(event)
			attacks.process_input(event)

func _physics_process(delta: float) -> void:
	if _can_play_steps:
		if _steps.size() > 0:
			var event := _steps.pop_front() as InputEvent
			if can_move:
				movements.process_input(event)
			attacks.process_input(event)
		else:
			_can_play_steps = false
		
	if can_move:
		movements.process_physics(delta)
	attacks.process_physics(delta)
	
	velocity += get_gravity() * delta
	move_and_slide()

func _process(delta: float) -> void:
	if can_move:
		movements.process_frame(delta)
	attacks.process_frame(delta)

func get_movement(event: InputEvent) -> float:
	var movement: float = 0
	if event.is_action("left"):
		movement = -Settings.Distance
	elif event.is_action("right"):
		movement = Settings.Distance
	return movement

func move(movement: float, delta: float) -> void:
	if movement != 0:
		animations.flip_h = movement < 0
		move_position.x += movement
	velocity.x = position.direction_to(move_position).x * Settings.Speed * delta
