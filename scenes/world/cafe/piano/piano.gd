extends KinematicBody2D

onready var hud := $"/root/Main/Hud"
onready var audio := $AudioStreamPlayer2D
onready var poi := $PointOfInterest


func interact() -> void:
	if audio.playing:
		return

	Facts.has_played_piano = true

	audio.play()
	hud.show_message(
		"... ... ... ... \nThis tune sounds... [wave][color=#b00]familiar[/color][/wave]!"
	)


func _physics_process(delta: float) -> void:
	poi.visible = !Facts.has_played_piano
