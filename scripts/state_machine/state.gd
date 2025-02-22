class_name State
extends Node

@export var animation_name: String

var parent: PhysicsBody2D

func enter() -> void:
	print(parent.name, ' -> ', name)
	parent.animations.play(animation_name)

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
	
func animation_finished() -> State:
	return null
