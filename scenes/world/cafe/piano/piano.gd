extends KinematicBody2D

onready var audio = $AudioStreamPlayer2D


func interact() -> void:
	if not audio.playing:
		audio.play()
