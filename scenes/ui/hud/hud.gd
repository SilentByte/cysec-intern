extends CanvasLayer
class_name Hud

onready var debug_label := $Container/DebugLabel

onready var panel := $Container/Panel
onready var panel_label := $Container/Panel/RichTextLabel
onready var panel_text_timer := $Container/Panel/TextTimer

onready var bottom_panel := $Container/BottomPanel
onready var bottom_panel_label := $Container/BottomPanel/RichTextLabel
onready var bottom_panel_text_timer := $Container/BottomPanel/TextTimer
onready var bottom_panel_tween := $Container/BottomPanel/Tween

onready var chime_default := $ChimeDefault
onready var chime_good := $ChimeGood
onready var chime_bad := $ChimeBad

const BOTTOM_PANEL_INSIDE_Y := 230
const BOTTOM_PANEL_OUTSIDE_Y := 500
const BOTTOM_PANEL_SLIDE_DURATION := 0.5

var panel_content := {}
var is_bottom_panel_visible := false


func _ready() -> void:
	panel.hide()


func _process(_delta: float) -> void:
	var debug_info := PoolStringArray(
		[
			"%d FPS " % Engine.get_frames_per_second(),
			"%.2f MSPF" % (1.0 / Engine.get_frames_per_second() * 1000),
		]
	)

	debug_label.text = debug_info.join("\n")


func _input(event: InputEvent) -> void:
	if event.is_action("ui_cancel") and is_interacting():
		_close_panel()
		_close_bottom_panel()
		get_tree().set_input_as_handled()


func _play_chime(chime: String = "") -> void:
	match chime:
		"good":
			chime_good.play()
		"bad":
			chime_bad.play()
		_:
			chime_default.play()


func _next_panel_part(part: String) -> void:
	if part == "$end":
		_close_panel()
		return

	if not panel_content.has(part):
		push_error("Panel content does not have part '%s'" % part)
		_close_panel()
		return

	panel_label.bbcode_text = panel_content[part]
	panel_label.visible_characters = 0
	panel_text_timer.start()


func _close_panel() -> void:
	panel_content = {}
	panel.hide()


func _on_panel_text_timer_timeout() -> void:
	if panel_label.visible_characters == panel_label.text.length():
		panel_text_timer.stop()
	else:
		panel_label.visible_characters += 1


func _on_panel_meta_clicked(meta) -> void:
	meta = str(meta)

	if not meta.begins_with("$"):
		OS.shell_open(meta)
		return

	var parts = meta.split(":")
	_play_chime(Utils.at(parts, 1, "default"))
	_next_panel_part(parts[0])


func _close_bottom_panel() -> void:
	if is_bottom_panel_visible:
		_bottom_panel_slide_out()


func _bottom_panel_slide_in() -> void:
	is_bottom_panel_visible = true
	bottom_panel_tween.interpolate_property(
		bottom_panel,
		"rect_position",
		Vector2(bottom_panel.rect_position.x, BOTTOM_PANEL_OUTSIDE_Y),
		Vector2(bottom_panel.rect_position.x, BOTTOM_PANEL_INSIDE_Y),
		BOTTOM_PANEL_SLIDE_DURATION,
		Tween.TRANS_SINE,
		Tween.EASE_OUT
	)

	bottom_panel_tween.start()


func _bottom_panel_slide_out() -> void:
	is_bottom_panel_visible = false

	bottom_panel_text_timer.stop()
	bottom_panel_tween.interpolate_property(
		bottom_panel,
		"rect_position",
		Vector2(bottom_panel.rect_position.x, BOTTOM_PANEL_INSIDE_Y),
		Vector2(bottom_panel.rect_position.x, BOTTOM_PANEL_OUTSIDE_Y),
		BOTTOM_PANEL_SLIDE_DURATION,
		Tween.TRANS_SINE,
		Tween.EASE_IN
	)

	bottom_panel_tween.start()


func _on_bottom_panel_text_timer_timeout() -> void:
	if bottom_panel_label.visible_characters == bottom_panel_label.text.length():
		bottom_panel_text_timer.stop()
	else:
		bottom_panel_label.visible_characters += 1


func _on_close_button_pressed() -> void:
	_bottom_panel_slide_out()


func _on_bottom_panel_meta_clicked(meta) -> void:
	meta = str(meta)
	OS.shell_open(meta)


func is_interacting() -> bool:
	return panel.visible or is_bottom_panel_visible


func show_message(text: String) -> void:
	bottom_panel_label.bbcode_text = text
	bottom_panel_label.visible_characters = 0
	bottom_panel_text_timer.start()

	_bottom_panel_slide_in()


func show_dialog(content: Dictionary) -> void:
	if not content.has("$begin"):
		push_error("Panel content must have a beginning")
		return

	panel_content = content
	_next_panel_part("$begin")
	panel.show()
