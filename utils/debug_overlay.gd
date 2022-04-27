extends Node2D

onready var label = $CanvasLayer/MarginContainer/VBoxContainer/Label


func _process(_delta: float) -> void:
	var data := PoolStringArray(
		[
			"%d FPS " % Engine.get_frames_per_second(),
			"%.2f MSPF" % (1.0 / Engine.get_frames_per_second() * 1000),
		]
	)

	label.text = data.join("\n")
