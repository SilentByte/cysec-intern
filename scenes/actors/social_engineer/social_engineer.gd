extends KinematicBody2D

onready var hud := $"/root/Main/Hud"
onready var audio := $AudioStreamPlayer
onready var poi := $PointOfInterest


func interact() -> void:
	if audio.playing:
		return

	audio.play()
	hud.show_dialog(
		"social_engineer",
		{
			"$begin":
			Utils.dialog_part(
				"""
				Hey, are you the new intern? <~I'm Tammy!~>

				I need your help! :-( I think I forgot
				my badge at home and this <!stupid elevator!>
				won't let me get up to my floor without it.

				Could you help me with that?

				<?[url=$accept:bad]1) Sure, what floor are you working on?[/url]?>

				<?[url=$reject:good]2) I bet Fred at the reception could help with that.[/url]?>
				"""
			),
			"$accept":
			Utils.dialog_part(
				"""
				<!Err... bad idea!!>

				You don't know Tammy, do you? She might not be what
				you think she is and may not even work here.

				<!Social engineering!> is a tactic that is used to
				manipulate people into getting access to places
				or information.

				You should <!never!> share your access credentials
				or passwords with anyone.

				[center]<#[url=https://www.cisa.gov/uscert/ncas/tips/ST04-014]Click here to learn more.[/url]#>[/center]

				<?[url=$end]CONTINUE[/url]?>
				"""
			),
			"$reject":
			Utils.dialog_part(
				"""
				<~Good call!~>

				Tammy might not be the one she claims to be.

				<!Social engineering!> is a tactic that is used to
				manipulate people into getting access to places
				or information.

				You should <!never!> share your access credentials
				or passwords with anyone.

				[center]<#[url=https://www.cisa.gov/uscert/ncas/tips/ST04-014]Click here to learn more.[/url]#>[/center]

				<?[url=$end]CONTINUE[/url]?>
				"""
			),
		}
	)


func _physics_process(delta: float) -> void:
	poi.visible = !Facts.has_had_interaction("social_engineer")
