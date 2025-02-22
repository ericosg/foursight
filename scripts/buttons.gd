extends Node2D

@onready var buttons := $"."

const BUTTONS_FIT_ON_SCREEN = 31
	
func _unhandled_input(event: InputEvent) -> void:
	if not Global.CutScene:
		if event.is_action_pressed('up'):
			add_button(0)
		if event.is_action_pressed('right'):
			add_button(1)
		if event.is_action_pressed('down'):
			add_button(2)
		if event.is_action_pressed('left'):
			add_button(3)
		if event.is_action_pressed('fast'):
			add_button(4)
		if event.is_action_pressed('hard'):
			add_button(5)
		
func add_button(frame: int):
	var button := buttons.get_child(0)
	var next := button.duplicate()
	next.frame = frame
	buttons.position.x -= 16
	next.position.x = abs(buttons.position.x)
	next.visible = true
	add_child(next)
	if buttons.get_child_count() > BUTTONS_FIT_ON_SCREEN:
		button.queue_free()
