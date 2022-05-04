extends Node2D

const BOUNCE_MAGNITUDE := 3
const BOUNCE_SPEED_MULTIPLIER := 10

onready var sprite = $Sprite

var _delta := 0.0


func _physics_process(delta: float) -> void:
	_delta += delta
	sprite.position.y = sin(_delta * BOUNCE_SPEED_MULTIPLIER) * BOUNCE_MAGNITUDE
