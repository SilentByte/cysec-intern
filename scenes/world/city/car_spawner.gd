tool
extends Node2D

export var despawn_range := 64.0 setget _set_despawn_range
export var car_speed := 100.0 setget _set_car_speed
export(float, 0, 1000) var spawn_interval := 5.0 setget _set_spawn_interval
export(float, 0, 1000) var spawn_variability := 1.0 setget _set_spawn_variability
#export var spawning = false

const _car = preload("res://scenes/world/city/cars/car.tscn")

onready var _cars := $Cars
onready var _spawn_timer = $SpawnTimer


func _set_despawn_range(value: float) -> void:
	despawn_range = value
	reset()


func _set_car_speed(value: float) -> void:
	car_speed = value
	reset()


func _set_spawn_interval(value: float) -> void:
	spawn_interval = value
	reset()


func _set_spawn_variability(value: float) -> void:
	spawn_variability = value
	reset()


func _ready() -> void:
	reset()


func _draw() -> void:
	if not Engine.is_editor_hint():
		return

	draw_line(Vector2.ZERO, Vector2(despawn_range, 0), Color.red, 2)


func reset() -> void:
	if _cars:
		for c in _cars.get_children():
			c.queue_free()

	if _spawn_timer:
		_update_spawn_timer_interval()

	update()


func _physics_process(delta: float) -> void:
	if not _cars:
		return

	for c in _cars.get_children():
		c.position.x += sign(despawn_range) * car_speed * delta

		if abs(c.position.x) > abs(despawn_range):
			c.queue_free()


func _update_spawn_timer_interval() -> void:
	_spawn_timer.wait_time = max(
		0, spawn_interval + rand_range(-spawn_variability, spawn_variability)
	)
	_spawn_timer.start()


func _on_spawn_timer_timeout() -> void:
	if not _cars:
		return

	_update_spawn_timer_interval()

	var c = _car.instance()
	c.car_color = Utils.choose_randomly(["red", "green", "gray"])
	c.scale.x = sign(despawn_range)
	_cars.add_child(c)
