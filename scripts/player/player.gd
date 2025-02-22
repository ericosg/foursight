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
var can_play := false
var _steps: Array[InputEvent] = []

func _ready() -> void:
	stop()
	movements.init(self)
	attacks.init(self)

func _unhandled_input(event: InputEvent) -> void:
	if not Global.CutScene:
		if event.is_action_pressed("start"):
			can_play = true
			return

		if Helper.is_handled(event):
			_steps.push_back(event)
			if not Global.IsFrozen():
				can_play = true

func _physics_process(delta: float) -> void:
	if can_play:
		if _steps.size() > 0:
			var event := _steps.pop_front() as InputEvent
			prepare_movement(event)
			print('event => ', event.as_text())
			if can_move:
				movements.process_input(event)
			if can_attack:
				attacks.process_input(event)
		else:
			can_play = false
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
		
func _on_animations_animation_finished() -> void:
	if can_move:
		movements.animation_finished()
	if can_attack:
		attacks.animation_finished()

func prepare_movement(event: InputEvent) -> void:
	var movement: float = 0
	if event.is_action("left"):
		movement = -Settings.Distance
	elif event.is_action("right"):
		movement = Settings.Distance
	if movement != 0:
		move_position.x += movement

func move() -> void:
	var distance := position.x - move_position.x
	var direction := -1 if distance > 0 else 1
	if abs(distance) > 1:
		animations.flip_h = direction < 0
		velocity.x = direction * Settings.Speed
	else:
		velocity.x = 0
	
func stop() -> void:
	velocity.x = 0
	move_position = position
	
func play() -> void:
	can_play = true
	
func pause() -> void:
	can_play = false
	
func hit() -> void:
	can_attack = false
	HP -= 1
	if get_tree():
		await get_tree().create_timer(0.5).timeout
		movements.change_state($movements/hit)
		can_attack = true
	if HP <= 0:
		stop()
		can_move = false
		can_attack = false
		if get_tree():
			await get_tree().create_timer(0.5).timeout
			movements.change_state($movements/death)
