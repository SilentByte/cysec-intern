extends StaticBody2D

export(String, MULTILINE) var message := ""
export(AudioStream) var stream = null

onready var hud := $"/root/Main/Hud"
onready var audio := $AudioStreamPlayer


func interact() -> void:
	if audio.playing:
		return

	audio.stream = stream
	audio.play()
	hud.show_message(Utils.dialog_part(message))
