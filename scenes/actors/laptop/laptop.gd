extends KinematicBody2D

export(String, "vpn", "upgrades", "exe") var mode = "vpn"

onready var hud := $"/root/Main/Hud"
onready var audio := $AudioStreamPlayer
onready var poi := $PointOfInterest

var dialog_content = {
	"vpn":
	{
		"$begin":
		Utils.dialog_part(
			"""
			This seems like a nice place to get some work done,
			and the <~WiFi is fast!~>

			The computer is asking me if I want to connect to the
			Company's Virtual Private Network (VPN)... Should I?

			<?[url=$accept:good]1) Yes, connect to the corporate network.[/url]?>

			<?[url=$reject:bad]2) Don't connect, I'm not sure I can trust this
			   connection because I'm using public WiFi.[/url]?>
			"""
		),
		"$accept":
		Utils.dialog_part(
			"""
			<~That's the correct choice!~>

			Using a VPN ensures that your connection is encrypted
			and secure, even if you are connected to a network
			you do not control.

			[center]<#[url=https://www.cyber.gov.au/acsc/view-all-content/guidance/use-secure-connection]Click here to learn more.[/url]#>[/center]

			<?[url=$end]CONTINUE[/url]?>
			"""
		),
		"$reject":
		Utils.dialog_part(
			"""
			<!You should connect to the VPN!!>

			Using a VPN ensures that your connection is encrypted
			and secure, even if you are connected to a network
			you do not control.

			[center]<#[url=https://www.cyber.gov.au/acsc/view-all-content/guidance/use-secure-connection]Click here to learn more.[/url]#>[/center]

			<?[url=$end]CONTINUE[/url]?>
			"""
		),
	},
}


func interact() -> void:
	if audio.playing:
		return

	Facts.found_laptop_modes.append(mode)

	audio.play()
	hud.show_dialog(dialog_content[mode])


func _physics_process(delta: float) -> void:
	poi.visible = !Facts.found_laptop_modes.has(mode)
