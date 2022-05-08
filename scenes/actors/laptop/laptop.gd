extends KinematicBody2D

export(String, "vpn", "upgrades", "exe", "2fa") var mode = "vpn"

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
	"upgrades":
	{
		"$begin":
		Utils.dialog_part(
			"""
			A message just popped up, looks like there are new
			upgrades and patches available for the operating
			system and for some applications.

			<?[url=$upgrade:good]1) It's gonna take a while, but I'll start upgrading.[/url]?>

			<?[url=$wait:bad]2) Not now, it's gonna take too long.[/url]?>
			"""
		),
		"$upgrade":
		Utils.dialog_part(
			"""
			<~Yes, get those latest patches!~>

			It's good practice to keep your system up-to-date,
			especially when it comes to applying new security
			patches and application upgrades.

			[center]<#[url=https://www.cyber.gov.au/learn/update-devices]Click here to learn more.[/url]#>[/center]

			<?[url=$end]CONTINUE[/url]?>
			"""
		),
		"$wait":
		Utils.dialog_part(
			"""
			<!The longer you wait, the less secure your system is!!>

			While it's sometimes not convenient to upgrade
			immediately, it's good practice to keep your
			system up-to-date, especially when it comes to
			applying new security patches and application upgrades.

			[center]<#[url=https://www.cyber.gov.au/learn/update-devices]Click here to learn more.[/url]#>[/center]

			<?[url=$end]CONTINUE[/url]?>
			"""
		),
	},
	"2fa":
	{
		"$begin":
		Utils.dialog_part(
			"""
			I finally got around to create an account with that
			<~Cloud Service Provider~>. Now it's asking me if
			I want to enable <!Two Factor Authentication!>.

			I'm not sure... that always makes logging in so
			tedious and more time consuming...

			<?[url=$enable:good]1) I will enable 2FA.[/url]?>

			<?[url=$disable:bad]2) Not now, maybe later.[/url]?>
			"""
		),
		"$enable":
		Utils.dialog_part(
			"""
			<~Yes, always enable 2FA when available!~>

			2FA makes it much more difficult for attackers to get
			into your account, even if they got their hands on
			your password.

			Enabling 2FA is one of the most effective ways
			you can enhance your personal cybersecurity.

			[center]<#[url=https://www.techtarget.com/searchsecurity/definition/two-factor-authentication]Click here to learn more.[/url]#>[/center]

			<?[url=$end]CONTINUE[/url]?>
			"""
		),
		"$disable":
		Utils.dialog_part(
			"""
			<!That's not the most secure decision...!>

			2FA makes it much more difficult for attackers to get
			into your account, even if they got their hands on
			your password.

			Enabling 2FA is one of the most effective ways
			you can enhance your personal cybersecurity.

			[center]<#[url=https://www.techtarget.com/searchsecurity/definition/two-factor-authentication]Click here to learn more.[/url]#>[/center]

			<?[url=$end]CONTINUE[/url]?>
			"""
		),
	},
}


func interact() -> void:
	if audio.playing:
		return

	audio.play()
	hud.show_dialog("laptop:%s" % mode, dialog_content[mode])


func _physics_process(delta: float) -> void:
	poi.visible = !Facts.has_had_interaction("laptop:%s" % mode)
