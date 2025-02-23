class_name Player
extends CharacterBody2D

@export var HP := 1

@onready var animations: AnimatedSprite2D = $animations
@onready var area: Area2D = $area
@onready var movements = $movements
@onready var attacks = $attacks

var can_show_movements := true
var move_position: Vector2
var can_play := false

class LinkedEvent:
	var event: InputEvent
	var is_linked: bool = true
	
	func _init(event: InputEvent, is_linked: bool = true):
		self.event = event
		self.is_linked = is_linked

var _steps: Array[LinkedEvent] = []

func _ready() -> void:
	stop()
	movements.init(self)
	attacks.init(self)

func _unhandled_input(event: InputEvent) -> void:
	# TODO: After "start" no input should be accepted until the stack ends
	if not Global.CutScene:
		if event.is_action_pressed("start"):
			$linked.stop()
			can_play = true
			return

		if Helper.is_handled(event):
			$linked.start(0.8)
			_steps.push_back(LinkedEvent.new(event))
			if not Global.IsFrozen():
				can_play = true

func _physics_process(delta: float) -> void:
	if can_play:
		if _steps.size() > 0:
			var linkedEvent := _steps.pop_front() as LinkedEvent
			prepare_movement(linkedEvent.event)
			print('event => ', linkedEvent.event.as_text())
			movements.process_input(linkedEvent.event)
			attacks.process_input(linkedEvent.event)
			can_play = linkedEvent.is_linked
		else:
			can_play = false
	velocity += get_gravity() * delta
	move_and_slide()
	movements.process_physics(delta)
	attacks.process_physics(delta)

func _process(delta: float) -> void:
	movements.process_frame(delta)
	attacks.process_frame(delta)
		
func _on_animations_animation_finished() -> void:
	movements.animation_finished()
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
	can_play = false
	HP -= 1
	if get_tree():
		await get_tree().create_timer(0.5).timeout
		movements.change_state($movements/hit)
		can_play = true
	if HP <= 0:
		stop()
		can_play = false
		Global.CutScene = true
		if get_tree():
			await get_tree().create_timer(0.5).timeout
			movements.change_state($movements/death)

func _on_linked_timeout() -> void:
	if Global.IsFrozen() and _steps.size() > 0:
		print("LINK FAILED")
		_steps[_steps.size() - 1].is_linked = false
