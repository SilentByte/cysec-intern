extends KinematicBody2D

onready var hud := $"/root/Main/Hud"
onready var audio := $AudioStreamPlayer
onready var poi := $PointOfInterest

var _last_completion_ratio := -1.0


func interact() -> void:
	if audio.playing:
		return

	audio.play()
	_last_completion_ratio = Facts.completion_ratio()

	var content := ""
	if Facts.scored_interaction_count() < Facts.TOTAL_SCORABLE_INTERACTION_COUNT:
		content = (
			"""
			<~Hey, my new favorite intern! :-)~>

			I'm Maria and I'm in charge of this department.

			So far, you have found <!%s out of %s challenges!>,
			with an <!overall score of %s%%!>.

			Keep at it! There's more to learn.

			<?[url=$end]CONTINUE[/url]?>
			"""
			% [
				Facts.scored_interaction_count(),
				Facts.TOTAL_SCORABLE_INTERACTION_COUNT,
				round(Facts.total_score() * 100.0),
			]
		)
	else:
		content = (
			"""
			<~Hey, my new favorite intern! :-)~>

			Amazing! Looks like you have found <!ALL %s!> challenges!
			and reached an <!overall score of %s%%!>.

			<?[url=$end]CONTINUE[/url]?>
			"""
			% [
				Facts.TOTAL_SCORABLE_INTERACTION_COUNT,
				round(Facts.total_score() * 100.0),
			]
		)

	hud.show_dialog(
		"boss",
		{
			"$begin": Utils.dialog_part(content),
		}
	)


func _physics_process(delta: float) -> void:
	poi.visible = _last_completion_ratio != Facts.total_score()
