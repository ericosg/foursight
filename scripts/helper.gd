extends Node

func is_handled(event: InputEvent) -> bool:
	return event.is_action_pressed("fast") or event.is_action_pressed("hard") or event.is_action_pressed("up") or event.is_action_pressed("right") or event.is_action_pressed("down") or event.is_action_pressed("left")
