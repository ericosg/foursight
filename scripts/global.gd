extends Node

var CutScene := false
var _frozen := false

func Freeze(status: bool = true) -> void:
	_frozen = status
	FrozenChanged.emit()

func IsFrozen() -> bool:
	return _frozen

signal FrozenChanged
