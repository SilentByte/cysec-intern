extends Node2D

const TRANSITION_DURATION = 1.5

onready var surface := $CanvasLayer/TextureRect

var transition_delta := 0.0
var transition_textures := [
	preload("res://actors/transition_manager/transitions/pixelate.png"),
	preload("res://actors/transition_manager/transitions/rotate.png"),
	preload("res://actors/transition_manager/transitions/triangles.png"),
	preload("res://actors/transition_manager/transitions/diagonal.png"),
	preload("res://actors/transition_manager/transitions/spiral.png"),
]


func is_transitioning() -> bool:
	return surface.texture != null


func transition() -> void:
	var image := get_viewport().get_texture().get_data()
	image.flip_y()

	var texture := ImageTexture.new()
	texture.create_from_image(image)

	transition_delta = 0.0

	surface.material.set_shader_param(
		"transition_texture", Utils.choose_randomly(transition_textures)
	)
	surface.texture = texture

	yield(get_tree().create_timer(TRANSITION_DURATION), "timeout")
	surface.texture = null


func _physics_process(delta: float) -> void:
	if surface.texture == null:
		return

	transition_delta += delta / TRANSITION_DURATION
	surface.material.set_shader_param("transition_delta", transition_delta)
