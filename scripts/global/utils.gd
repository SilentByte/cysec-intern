extends Node

var MULTI_WHITE_SPACE_REGEX = RegEx.new()


func _init() -> void:
	MULTI_WHITE_SPACE_REGEX.compile("\\s+")


func try_call(object: Object, method_name: String, args: Array = []):
	if object.has_method(method_name):
		return object.callv(method_name, args)


func choose_randomly(array: Array):
	if array.empty():
		return null

	return array[randi() % len(array)]


func dialog_part(text: String) -> String:
	text = text.replace("\n\n", "%%DOUBLE_LINE_BREAK%%")
	text = MULTI_WHITE_SPACE_REGEX.sub(text, " ", true)
	text = text.replace("%%DOUBLE_LINE_BREAK%%", "\n")
	text = text.dedent()
	text = text.strip_edges()
	return text
