extends KinematicBody2D

onready var hud := $"/root/Main/Hud"
onready var audio := $AudioStreamPlayer
onready var poi := $PointOfInterest


func interact() -> void:
	if audio.playing:
		return

	audio.play()
	hud.show_dialog(
		"ice_cream_guy",
		{
			"$begin":
			Utils.dialog_part(
				"""
				OH HI, care for some [rainbow]ICE CREAM[/rainbow]?

				I've got vanilla, chocolate, strawberry, ...

				<?[url=$accept]1) YES PLEASE![/url]?>

				<?[url=$reject]2) Not now, maybe next time.[/url]?>
				"""
			),
			"$accept":
			Utils.dialog_part(
				"""
				<!AWESOME!!> By the way, we've got a special offer going on at the moment.

				If you sign up for our <~weekly newsletter~>, you'll get 50% off today!

				<?[url=$sign-up:bad]1) Write down your e-mail address into the list
				   in front of you.[/url]?>

				<?[url=$leave:good]2) No thanks, I'm not interested.[/url]?>
				"""
			),
			"$reject":
			Utils.dialog_part(
				"""
				Sure, no problem!

				In case you change your mind, we've got a special offer going on at the moment.

				If you sign up for our <~weekly newsletter~>, you'll get 50% off today!

				<?[url=$sign-up:bad]1) Write down your e-mail address into the list
				   in front of you.[/url]?>

				<?[url=$leave:good]2) No thanks, I'm not interested.[/url]?>
				"""
			),
			"$sign-up":
			Utils.dialog_part(
				"""
				Well, you've just saved $2 but it's likely that your
				e-mail address will end up on some <!spam list!> and
				you'll see an increase in the number of unwanted
				e-mails you receive.

				Be mindful to whom you hand out your e-mail address.

				<?[url=$end]CONTINUE[/url]?>
				"""
			),
			"$leave":
			Utils.dialog_part(
				"""
				<~That's a good choice.~>

				Be mindful to whom you provide your e-mail address or
				you might end up on some spam list and receive tons
				of e-mails you don't want.

				<?[url=$end]CONTINUE[/url]?>
				"""
			),
		}
	)


func _physics_process(delta: float) -> void:
	poi.visible = !Facts.has_had_interaction("ice_cream_guy")
