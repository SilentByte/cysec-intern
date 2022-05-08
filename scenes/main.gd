extends Node2D

onready var hud := $Hud


func _ready() -> void:
	if OS.is_debug_build():
		return

	hud.show_dialog(
		"welcome",
		{
			"$begin":
			Utils.dialog_part(
				"""
				<!HI THERE!>

				We at CySec Inc. welcome you as our new intern! :-)
				Give yourself some time to explore this part of town
				and then make your way to our office in the NORTH-EAST.

				Use WASD keys to move, E to interact, and use
				your mouse to select options.

				[center]<?[url=$end]CLOSE[/url]?>[/center]
				"""
			),
		}
	)


func _unhandled_input(_event: InputEvent) -> void:
	if not OS.is_debug_build():
		return

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().free()
