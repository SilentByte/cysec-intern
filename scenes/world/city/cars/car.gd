extends KinematicBody2D

export(String, "red", "green", "gray") var car_color := "red"

onready var _sprite := $Sprite
onready var _front_wheel := $Sprite/FrontWheel
onready var _back_wheel := $Sprite/BackWheel
onready var _audio := $AudioStreamPlayer2D

onready var _front_wheel_origin: Vector2 = _front_wheel.position
onready var _back_wheel_origin: Vector2 = _back_wheel.position

const _car_textures = {
	"red": preload("res://scenes/world/city/cars/red_car.png"),
	"green": preload("res://scenes/world/city/cars/green_car.png"),
	"gray": preload("res://scenes/world/city/cars/gray_car.png"),
}

var _delta_offset := 0.0


func _ready() -> void:
	_audio.play()


func _physics_process(delta: float) -> void:
	_delta_offset += delta

	_sprite.texture = _car_textures[car_color]

	_front_wheel.position.y = _front_wheel_origin.y + sin(_delta_offset * 20) / 2
	_back_wheel.position.y = _back_wheel_origin.y + sin(_delta_offset * 20) / 2

	_front_wheel.rotation_degrees += delta * 360
	_back_wheel.rotation_degrees += delta * 360
