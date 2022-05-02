extends KinematicBody2D

onready var hud = $"/root/Main/Hud"
onready var audio = $AudioStreamPlayer2D


func interact() -> void:
	if audio.playing:
		return

	audio.play()
	hud.show_message(
		"... ... ... ... \nThis tune sounds... [wave][color=#b00]familiar[/color][/wave]!"
	)
