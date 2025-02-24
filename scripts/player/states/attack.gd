class_name Attack
extends State

@export var sheath_state: State
@export var fast_state: State
@export var hard_state: State
@export var fast_collision_radius := Settings.DEFAULT_FAST_COLLISION_RADIUS

@onready var fast_collision = $"../../area/fast"

var next_state: State

func enter() -> void:
	super()
	fast_collision.shape.radius = fast_collision_radius
	parent.pause()
	parent.can_show_movements = false
	next_state = null
	destroy_enemies()

func exit() -> void:
	super()
	destroy_enemies()
	parent.can_show_movements = true
	parent.play()

func destroy_enemies() -> void:
	if parent is Player:
		var area = (parent as Player).area
		if area.has_overlapping_bodies(): # Area2D $area set to mask layer 2 as per Enemy
			var bodies := area.get_overlapping_bodies()
			for body in bodies:
				if body is Enemy:
					(body as Enemy).die()

func process_input(event: InputEvent) -> State:
	if fast_state && event.is_action('fast'):
		next_state = fast_state
	if hard_state && event.is_action('hard'):
		next_state = hard_state
	return null

func animation_finished() -> State:
	# TODO: Would be great if you could stack more than 2 attacks
	return next_state if next_state else sheath_state
