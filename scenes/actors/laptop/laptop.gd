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
	"exe":
	{
		"$begin":
		Utils.dialog_part(
			"""
			Ah, it's so nice to sit outside and <~relax a bit~>.

			Looks like my buddy Jake sent me a chat message:

			<#Hey, zup! I've been playing this crazy new video
			game, it's so competitive! I'm sending it to
			you, let's play!

			Sending starbattleroyale.exe ... ... ... ... ...
			File Transfer Completed.#>

			<?[url=$accept:bad]1) Awesome! Let's gooooooo![/url]?>

			<?[url=$reject:good]2) Thanks, but I'm going to get my own copy later.[/url]?>
			"""
		),
		"$accept":
		Utils.dialog_part(
			"""
			<!That was extremely risky!>

			You have received an executable file. While Jake may
			have good intensions, the EXE file might be infected
			with malicious software.

			You should be extremely careful when receiving
			executable files. <!Don't just open them!!>

			[center]<#[url=https://blog.malwarebytes.com/explained/2021/10/what-is-an-exe-file-is-it-the-same-as-an-executable/]Click here to learn more.[/url]#>[/center]

			<?[url=$end]CONTINUE[/url]?>
			"""
		),
		"$reject":
		Utils.dialog_part(
			"""
			<~Yes, it's good to be on the safe side!~>

			You have received an executable file. While Jake may
			have good intensions, the EXE file might be infected
			with malicious software.

			You should be extremely careful when receiving
			executable files. <!Don't just open them!!>

			[center]<#[url=https://blog.malwarebytes.com/explained/2021/10/what-is-an-exe-file-is-it-the-same-as-an-executable/]Click here to learn more.[/url]#>[/center]

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