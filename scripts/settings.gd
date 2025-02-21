extends Node

const _delta = 0.016

const Distance = 20.0 / _delta
const Speed = 100.0 / _delta
const JumpVelocity = -JumpForce / _delta
const JumpForce = 300.0
const FrozenColor = Color(0.2, 0.1, 1.0)
const FrozenSpeedScale = 0.2
const NormalColor = Color(1.0, 1.0, 1.0)
const NormalSpeedScale = 1.0
#const GameColor = Color(0.5, 0.5, 1.0)
