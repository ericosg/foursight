class_name Player
extends CharacterBody2D

@export var HP := 1

@onready var animations: AnimatedSprite2D = $animations
@onready var area: Area2D = $area
@onready var movements = $movements
@onready var attacks = $attacks

var can_move := true
var can_attack := true
var move_position: Vector2
var _steps: Array[InputEvent] = []
var _can_play_steps := false

func _ready() -> void:
	stop()
	movements.init(self)
	attacks.init(self)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("start"):
		_can_play_steps = true
		return
		
	prepare_movement(event)
		
	if Helper.is_handled(event):
		if Global.IsFrozen():
			_steps.push_back(event)
		elif not Global.CutScene:
			if can_move:
				movements.process_input(event)
			if can_attack:
				attacks.process_input(event)

func _physics_process(delta: float) -> void:
	if _can_play_steps:
		if _steps.size() > 0:
			var event := _steps.pop_front() as InputEvent
			if can_move:
				movements.process_input(event)
			if can_attack:
				attacks.process_input(event)
		else:
			_can_play_steps = false
		
	if can_move:
		movements.process_physics(delta)
	if can_attack:
		attacks.process_physics(delta)
	
	velocity += get_gravity() * delta
	move_and_slide()

func _process(delta: float) -> void:
	if can_move:
		movements.process_frame(delta)
	if can_attack:
		attacks.process_frame(delta)

func prepare_movement(event: InputEvent) -> void:
	var movement: float = 0
	if event.is_action("left"):
		movement = -Settings.Distance
	elif event.is_action("right"):
		movement = Settings.Distance
	
	if movement != 0:
		move_position.x += movement

func move(delta: float) -> void:
	var direction := position.direction_to(move_position).x
	animations.flip_h = direction < 0
	velocity.x = direction * Settings.Speed * delta
	
func stop() -> void:
	_steps.clear()
	velocity.x = 0
	move_position = position
	
func hit() -> void:
	can_attack = false
	HP -= 1
	if get_tree():
		await get_tree().create_timer(0.5).timeout
		animations.play("Hit")
		can_attack = true
		
	if HP <= 0:
		stop()
		can_move = false
		can_attack = false
		if get_tree():
			await get_tree().create_timer(0.5).timeout
			animations.play("Death")
		if get_tree():
			await get_tree().create_timer(1.5).timeout
			Global.Die()
