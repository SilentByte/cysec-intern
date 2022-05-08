extends KinematicBody2D

onready var hud := $"/root/Main/Hud"
onready var audio := $AudioStreamPlayer
onready var poi := $PointOfInterest


func interact() -> void:
	if audio.playing:
		return

	audio.play()
	hud.show_dialog(
		"spy",
		{
			"$begin":
			Utils.dialog_part(
				"""
				<!YOU! MIND YOUR OWN BUSINESS! GET LOST!!>

				<#... ... ... ... ... ... ... ...#>

				Woah, what's up with that guy? What's he doing anyway?

				<?[url=$ignore:bad]1) I better leave, I don't want to get into trouble.[/url]?>

				<?[url=$report:good]2) I think I should tell the receptionist inside.
				   I have a bad feeling about this.[/url]?>
				"""
			),
			"$ignore":
			Utils.dialog_part(
				"""
				<!You should probably tell someone.!>

				This guy looks like he doesn't belong there.
				If you see something suspicious, tell someone about it.

				<?[url=$end]CONTINUE[/url]?>
				"""
			),
			"$report":
			Utils.dialog_part(
				"""
				<~Good idea!~>

				This guy looks like he doesn't belong there.
				If you see something suspicious, tell someone about it.

				<?[url=$end]CONTINUE[/url]?>
				"""
			),
		}
	)


func _physics_process(delta: float) -> void:
	poi.visible = !Facts.has_had_interaction("spy")
