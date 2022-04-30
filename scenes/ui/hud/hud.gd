extends CanvasLayer

onready var bottom_panel := $Container/BottomPanel
onready var bottom_panel_label := $Container/BottomPanel/RichTextLabel
onready var bottom_panel_text_timer := $Container/BottomPanel/TextTimer
onready var bottom_panel_tween := $Container/BottomPanel/Tween

const BOTTOM_PANEL_INSIDE_Y := 230
const BOTTOM_PANEL_OUTSIDE_Y := 500
const BOTTOM_PANEL_SLIDE_DURATION := 0.5


func show_message(text: String) -> void:
	bottom_panel_label.bbcode_text = text
	bottom_panel_label.visible_characters = 0
	bottom_panel_text_timer.start()

	_slide_in()


func _slide_in() -> void:
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


func _slide_out() -> void:
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
	print("CLOSE")
	_slide_out()
