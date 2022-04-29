extends KinematicBody2D

const SPEED := 50
const RUN_MULTIPLIER := 2
const INTERACTION_DISTANCE := 8

onready var animated_sprite := $AnimatedSprite
onready var forward_ray_cast := $ForwardRayCast

var movement_direction := Vector2.ZERO
var facing_direction := "east"
var is_running := false


func _ready() -> void:
	$AnimatedSprite.play()


func _physics_process(_delta: float) -> void:
	_process_input()
	_process_animation()
	_process_movement()


func _update_forward_ray_cast() -> void:
	match facing_direction:
		"east":
			forward_ray_cast.cast_to = Vector2.RIGHT * INTERACTION_DISTANCE
		"west":
			forward_ray_cast.cast_to = Vector2.LEFT * INTERACTION_DISTANCE
		"north":
			forward_ray_cast.cast_to = Vector2.UP * INTERACTION_DISTANCE
		"south":
			forward_ray_cast.cast_to = Vector2.DOWN * INTERACTION_DISTANCE


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

	if Input.is_action_just_pressed("interact"):
		var interactable = forward_ray_cast.get_collider()
		if forward_ray_cast.is_colliding():
			Utils.try_call(interactable, "interact")

	is_running = Input.is_action_pressed("run")


func _process_animation() -> void:
	var action

	if movement_direction == Vector2.ZERO:
		action = "idle"
	else:
		action = "walk"

	animated_sprite.speed_scale = int(is_running) * RUN_MULTIPLIER + 1
	animated_sprite.animation = "%s_%s" % [facing_direction, action]


func _process_movement() -> void:
	var speed = SPEED
	if is_running:
		speed *= RUN_MULTIPLIER

	_update_forward_ray_cast()
	move_and_slide(movement_direction.normalized() * speed)
