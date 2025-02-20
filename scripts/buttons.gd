extends Node2D

@onready var buttons := $"."

const BUTTONS_FIT_ON_SCREEN = 31
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed('up'):
		add_button(0)
	if Input.is_action_just_pressed('right'):
		add_button(1)
	if Input.is_action_just_pressed('down'):
		add_button(2)
	if Input.is_action_just_pressed('left'):
		add_button(3)
	if Input.is_action_just_pressed('fast'):
		add_button(4)
	if Input.is_action_just_pressed('hard'):
		add_button(5)
		
func add_button(frame: int):
	var button := buttons.get_child(0)
	var next := button.duplicate()
	next.frame = frame
	buttons.position.x -= 16
	next.position.x = abs(buttons.position.x)
	add_child(next)
	if buttons.get_child_count() > BUTTONS_FIT_ON_SCREEN:
		button.queue_free()
