extends Node

var CutScene := false
var _frozen := false

signal Died
signal FrozenChanged

func Freeze(status: bool = true) -> void:
	_frozen = status
	FrozenChanged.emit()

func IsFrozen() -> bool:
	return _frozen

func Die() -> void:
	Died.emit()
	if get_tree():
		get_tree().reload_current_scene() 
