extends KinematicBody2D

onready var hud := $"/root/Main/Hud"
onready var audio := $AudioStreamPlayer
onready var poi := $PointOfInterest


func interact() -> void:
	if audio.playing:
		return

	audio.play()
	hud.show_dialog(
		"usb_stick",
		{
			"$begin":
			Utils.dialog_part(
				"""
				Oh hey, would you look at that!

				I found an absolutely <~gargantuous~> <!USB STICK!>! ^_^
				Someone must have lost it... I want to give it back.

				<?[url=$laptop:bad]1) I should plug it into my laptop, maybe there are
				   some files on it that tell me who the owner is.[/url]?>

				<?[url=$reception:good]2) I should take it to the reception, the owner will
				   probably come back to get it.[/url]?>
				"""
			),
			"$laptop":
			Utils.dialog_part(
				"""
				THAT'S A <!VERY BAD IDEA!>!

				A USB device may contain malicious software that could
				infect your computer and access your personal data.

				You should <!never!> plug-in unknown devices into your
				laptop or work computer as they may compromise the
				security of your computer and network.

				[center]<#[url=https://www.redteamsecure.com/blog/usb-drop-attacks-the-danger-of-lost-and-found-thumb-drives]Click here to learn more.[/url]#>[/center]

				<?[url=$end]CONTINUE[/url]?>
				"""
			),
			"$reception":
			Utils.dialog_part(
				"""
				Good choice!

				A USB device may contain malicious software that could
				infect your computer and access your personal data.

				You should <!never!> plug-in unknown devices into your
				laptop or work computer as they may compromise the
				security of your computer and network.

				[center]<#[url=https://www.redteamsecure.com/blog/usb-drop-attacks-the-danger-of-lost-and-found-thumb-drives]Click here to learn more.[/url]#>[/center]

				<?[url=$end]CONTINUE[/url]?>
				"""
			),
		}
	)


func _physics_process(delta: float) -> void:
	poi.visible = !Facts.has_had_interaction("usb_stick")
