tool
extends Node


func try_call(object: Object, method_name: String, args: Array = []):
	if object.has_method(method_name):
		return object.callv(method_name, args)


func choose_randomly(array: Array):
	if array.empty():
		return null

	return array[randi() % len(array)]


func at(array: Array, index: int, default = null):
	if len(array) > index:
		return array[index]
	else:
		return default


func dialog_part(text: String) -> String:
	text = text.replace("<!", "[color=#d00]")
	text = text.replace("!>", "[/color]")

	text = text.replace("<?", "[color=#194afc]")
	text = text.replace("?>", "[/color]")

	text = text.replace("<#", "[color=#888]")
	text = text.replace("#>", "[/color]")

	text = text.replace("<~", "[color=#0d0][wave]")
	text = text.replace("~>", "[/wave][/color]")

	text = text.dedent()
	text = text.strip_edges()

	return text
