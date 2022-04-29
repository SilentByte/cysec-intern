extends KinematicBody2D

var movement_direction := Vector2.ZERO
var facing_direction := "east"


func _ready() -> void:
	$AnimatedSprite.play()


func _physics_process(_delta: float) -> void:
	_process_input()
	_process_animation()
	_process_movement()


func _process_input() -> void:
	movement_direction = Vector2.ZERO

	if Input.is_action_pressed("move_east"):
		movement_direction.x += 1.0
		facing_direction = "east"

	if Input.is_action_pressed("move_west"):
		movement_direction.x -= 1.0
		facing_direction = "west"

	if Input.is_action_pressed("move_north"):
		movement_direction.y -= 1.0
		facing_direction = "north"

	if Input.is_action_pressed("move_south"):
		movement_direction.y += 1.0
		facing_direction = "south"


func _process_animation() -> void:
	var action

	if movement_direction == Vector2.ZERO:
		action = "idle"
	else:
		action = "walk"

	$AnimatedSprite.animation = "%s_%s" % [facing_direction, action]


func _process_movement() -> void:
	move_and_slide(movement_direction.normalized() * 50)
