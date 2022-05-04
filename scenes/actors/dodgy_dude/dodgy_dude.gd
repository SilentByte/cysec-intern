extends KinematicBody2D

onready var hud := $"/root/Main/Hud"
onready var audio := $AudioStreamPlayer
onready var poi := $PointOfInterest


func interact() -> void:
	if audio.playing:
		return

	Facts.has_found_dodgy_dude = true

	audio.play()
	hud.show_dialog(
		{
			"$begin":
			Utils.dialog_part(
				"""
				Psst... hey, over here...

				I've got a <!great deal!> for you! Look at this shiny new
				<~iPhone 25 Superplus~>! I'll give it to you for $199.

				<#*You take a good look at the iPhone. It's in
				excellent condition and everything is working fine.*#>

				<?[url=$accept:bad]1) That sounds like a bargain! I'll take it![/url]?>

				<?[url=$reject:good]2) I don't trust this guy... I'll just leave.[/url]?>
				"""
			),
			"$accept":
			Utils.dialog_part(
				"""
				THAT WAS A <!RISKY DECISION!>!

				Congratulations! You may have just landed a great
				bargain... or may face <!serious consequences!>.

				The iPhone you have just purchased my contain spyware
				or other malicious software. Even worse, it may have
				been stolen and you have just purchased stolen goods.

				[center]<#[url=https://www.welivesecurity.com/2020/04/22/buying-secondhand-device-what-keep-in-mind/]Click here to learn more.[/url]#>[/center]

				<?[url=$end]CONTINUE[/url]?>
				"""
			),
			"$reject":
			Utils.dialog_part(
				"""
				<~Wise decision!~>

				The iPhone you have been offered may contain spyware
				or other malicious software. Even worse, it could
				have been stolen and the purchase of stolen goods
				is illegal in most juristictions.

				[center]<#[url=https://www.welivesecurity.com/2020/04/22/buying-secondhand-device-what-keep-in-mind/]Click here to learn more.[/url]#>[/center]

				<?[url=$end]CONTINUE[/url]?>
				"""
			),
		}
	)


func _physics_process(delta: float) -> void:
	poi.visible = !Facts.has_found_dodgy_dude
