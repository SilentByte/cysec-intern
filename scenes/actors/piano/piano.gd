extends KinematicBody2D

onready var hud := $"/root/Main/Hud"
onready var audio := $AudioStreamPlayer
onready var poi := $PointOfInterest


func interact() -> void:
	if audio.playing:
		return

	audio.play()
	hud.show_message(
		"piano", "... ... ... ... \nThis tune sounds... [wave][color=#b00]familiar[/color][/wave]!"
	)


func _physics_process(delta: float) -> void:
	poi.visible = !Facts.has_had_interaction("piano")
