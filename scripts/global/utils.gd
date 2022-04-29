extends Node


func try_call(object: Object, method_name: String, args: Array = []):
	if object.has_method(method_name):
		return object.callv(method_name, args)
