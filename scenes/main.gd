extends Node2D

onready var hud = $"/root/Main/Hud"


func _unhandled_input(_event: InputEvent) -> void:
	if not OS.is_debug_build():
		return

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().free()
