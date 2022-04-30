extends Node2D

export var portal_name = ""
export(String, FILE, "*.tscn") var target_scene

onready var world := $"/root/Main/World"
onready var player := $"/root/Main/Player"
onready var transition_manager := $"/root/Main/TransitionManager"
onready var area := $Area2D


func _on_body_entered(body: Node) -> void:
	print("Switching scene to %s @ %s" % [target_scene, portal_name])

	transition_manager.transition()

	world.get_child(0).queue_free()

	var scene = load(target_scene).instance()
	world.add_child(scene)

	var target_portal = scene.get_node("Portals/%s" % portal_name)
	player.teleport_to_global(target_portal.get_node("Target").global_position)
