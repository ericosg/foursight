extends State

@export var fast_state: State
@export var hard_state: State

@onready var fast_collision = $"../../area/fast"

func enter() -> void:
	super()
	fast_collision.shape.radius = Settings.DEFAULT_FAST_COLLISION_RADIUS
	parent.can_show_movements = true
	if not parent.has_steps():
		Global.Freeze()

func process_input(event: InputEvent) -> State:
	if event.is_action('fast'):
		return fast_state
	if event.is_action('hard'):
		return hard_state
	return null
