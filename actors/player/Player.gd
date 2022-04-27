extends Node2D

var movement_direction = Vector2.ZERO
var facing_direction = Vector2.ZERO

func _ready() -> void:
	$AnimatedSprite.play()

func _physics_process(delta: float) -> void:
	movement_direction = Vector2.ZERO

	if Input.is_action_pressed("move_east"):
		movement_direction.x += 1.0

	if Input.is_action_pressed("move_west"):
		movement_direction.x -= 1.0

	if Input.is_action_pressed("move_north"):
		movement_direction.y -= 1.0

	if Input.is_action_pressed("move_south"):
		movement_direction.y += 1.0

	_update_animation()
	position += movement_direction.normalized() * 100 * delta

func _update_animation():
	if movement_direction.x > 0:
		$AnimatedSprite.animation = "east_walk"
	elif movement_direction.x < 0:
		$AnimatedSprite.animation = "west_walk"
	elif movement_direction.y < 0:
		$AnimatedSprite.animation = "north_walk"
	elif movement_direction.y > 0:
		$AnimatedSprite.animation = "south_walk"
	else:
		$AnimatedSprite.animation = "east_idle"
