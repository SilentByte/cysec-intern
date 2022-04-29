extends Node2D

export var portal_name = ""
export(String, FILE, "*.tscn") var target_scene

onready var world = $"/root/Main/World"
onready var player = $"/root/Main/Player"

onready var area = $Area2D


func _on_body_entered(body: Node) -> void:
	print("Switching scene to %s @ %s" % [target_scene, portal_name])

	var scene = load(target_scene).instance()
	world.add_child(scene)

	var target_portal = scene.get_node("Portals/%s" % portal_name)
	player.portal_to_global(target_portal.get_node("Target").global_position)

	yield(get_tree(), "idle_frame")

	world.get_child(0).queue_free()
