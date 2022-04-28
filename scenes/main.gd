extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


func _unhandled_input(event: InputEvent) -> void:
	if not OS.is_debug_build():
		return

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().free()
