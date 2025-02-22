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
			add_button(6, false)
			print('action = ', event.as_text())
			
		
func add_button(frame: int, is_linked: bool = true):
	if is_linked:
		var linked_timer = $Timers.get_children()[$Timers.get_child_count() - 1] as AnimatedSprite2D
		if linked_timer.frame != 8:
			linked_timer.stop()
	var button := $Buttons.get_child(0)
	var next_button := button.duplicate()
	var timer := $Timers.get_child(0)
	var next_timer := timer.duplicate()
	next_button.frame = frame
	next_timer.frame = 0
	position.x -= 16
	next_button.position.x = abs(position.x)
	next_button.visible = true
	next_timer.position.x = abs(position.x)
	next_timer.visible = is_linked
	$Buttons.add_child(next_button)
	$Timers.add_child(next_timer)
	if get_child_count() > BUTTONS_FIT_ON_SCREEN:
		button.queue_free()
		next_timer.queue_free()
	
