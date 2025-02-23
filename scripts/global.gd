extends Node

var CutScene := false
var _frozen := false
var Seconds := 0.0
var Starts := 0
var Moves := 0

signal Died
signal FrozenChanged

func Freeze(status: bool = true) -> void:
	print('Starting ', 'frozen' if status else 'unfrozen')
	_frozen = status
	FrozenChanged.emit()

func IsFrozen() -> bool:
	return _frozen

func Die() -> void:
	Died.emit()
	if get_tree():
		await get_tree().create_timer(0.2).timeout
		get_tree().reload_current_scene() 
