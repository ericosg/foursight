extends Node2D

var dialog: Array[String] = [
	"You:\nYou can't stop me.\nNobody can.", 
	"Evil Dude:\nI'm faster than you think.", 
	"You:\nTry me!"
]

func _ready():
	Global.Freeze(false)
	Global.CutScene = true

func _unhandled_input(event: InputEvent) -> void:
	if Global.CutScene:
		if event.is_action_pressed("start") or event.is_action_pressed("up"):
			if len(dialog) > 0:
				$Dialog.text = str(dialog.pop_front())
				$Dialog.horizontal_alignment = 2 if $Dialog.horizontal_alignment == 0 else 0
			else:
				Global.CutScene = false
				$Instructions.queue_free()
				$Enemy.start()
				await get_tree().create_timer(0.5).timeout
				$Player/Camera.offset.x = 32
				$Player/Camera.zoom = Vector2(4 ,4)
				await get_tree().create_timer(0.5).timeout
				$Dialog.text = ""
	else:
		if event.is_action_pressed("fast") or event.is_action_pressed("hard"):
			await get_tree().create_timer(0.5).timeout
			$Player/Camera.offset.x = 0
			$Player/Camera.zoom = Vector2(2 ,2)
			await get_tree().create_timer(0.5).timeout
			

func _on_enemy_tree_exited() -> void:
	$Dialog.text = "You:\nI can see all possible futures.\n\nNothing can go wrong..."
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/stage1.tscn")
