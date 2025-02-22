extends Node2D

const BUTTONS_FIT_ON_SCREEN = 31
	
func _unhandled_input(event: InputEvent) -> void:
	if not Global.CutScene:
		if event.is_action_pressed('up'):
			add_button(0)
			print('action = ', event.as_text())
		if event.is_action_pressed('right'):
			add_button(1)
			print('action = ', event.as_text())
		if event.is_action_pressed('down'):
			add_button(2)
			print('action = ', event.as_text())
		if event.is_action_pressed('left'):
			add_button(3)
			print('action = ', event.as_text())
		if event.is_action_pressed('fast'):
			add_button(4)
			print('action = ', event.as_text())
		if event.is_action_pressed('hard'):
			add_button(5)
			print('action = ', event.as_text())
		if event.is_action_pressed('start'):
			add_button(6)
			print('action = ', event.as_text())
			
		
func add_button(frame: int):
	var button := get_child(0)
	var next := button.duplicate()
	next.frame = frame
	position.x -= 16
	next.position.x = abs(position.x)
	next.visible = true
	add_child(next)
	if get_child_count() > BUTTONS_FIT_ON_SCREEN:
		button.queue_free()
