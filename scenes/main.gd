extends Node2D

onready var hud := $Hud


func _ready() -> void:
	hud.show_dialog(
		{
			"$begin":
			Utils.dialog_part(
				"""
					[color=#b00]HI THERE![/color]



					We at CySec Inc. welcome you as our new intern! :-)
					Give yourself some time to explore this part of town and then make your way to
					our office in the NORTH-EAST.



					[center][color=#0b0][url=$end]CLOSE[/url][/color][/center]
				"""
			),
		}
	)


func _unhandled_input(_event: InputEvent) -> void:
	if not OS.is_debug_build():
		return

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().free()
