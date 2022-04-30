extends KinematicBody2D

onready var hud = $"/root/Main/Hud"
onready var audio = $AudioStreamPlayer2D


func interact() -> void:
	if audio.playing:
		return

	audio.play()
	hud.show_message("This music sounds... [color=#b00]familiar[/color]!")
