extends KinematicBody2D

onready var hud := $"/root/Main/Hud"
onready var audio := $AudioStreamPlayer
onready var poi := $PointOfInterest


func interact() -> void:
	if audio.playing:
		return

	Facts.has_found_poster = true

	audio.play()
	hud.show_dialog(
		{
			"$begin":
			Utils.dialog_part(
				"""
				That's a cool poster for a very <~interesting event!~>
				I'd love to check it out. Looks like there's a QR Code
				conveniently attached.

				[center][img=96]res://scenes/actors/poster/qrcode.png[/img][/center]

				<?[url=$leave:good]1) I'll check it out later.[/url]?>

				<?[url=$scan:bad]2) Quickly scan the QR code, I'm curious.[/url]?>
				"""
			),
			"$scan":
			Utils.dialog_part(
				"""
				Scanning... Bleep bloop, you may have just accessed
				a <!scam website!!>

				QR Codes can link to all sorts of targets, such as
				websites, e-mail addresses, contacts, phone numbers,
				and more.

				Sometimes, you might end up on a phishing website
				trying to get your passwords. Take extra care
				when scanning!

				[center]<#[url=https://www.cnet.com/tech/services-and-software/qr-code-scams-are-on-the-rise-heres-how-to-avoid-getting-duped/]Click here to learn more.[/url]#>[/center]

				<?[url=$end]CONTINUE[/url]?>
				"""
			),
			"$leave":
			Utils.dialog_part(
				"""
				<~Not every QR Code has to be scanned...~>

				QR Codes can link to all sorts of targets, such as
				websites, e-mail addresses, contacts, phone numbers,
				and more.

				Sometimes, you might end up on a phishing website
				trying to get your passwords. Take extra care
				when scanning!

				[center]<#[url=https://www.cnet.com/tech/services-and-software/qr-code-scams-are-on-the-rise-heres-how-to-avoid-getting-duped/]Click here to learn more.[/url]#>[/center]

				<?[url=$end]CONTINUE[/url]?>
				"""
			),
		}
	)


func _physics_process(delta: float) -> void:
	poi.visible = !Facts.has_found_poster
