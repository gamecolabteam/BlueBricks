class_name Game extends Node


@onready var level: Node = $Level
var loaded_level: Level


func _ready() -> void:
	if level.get_child_count() > 0:
		for ci in level.get_child_count():
			var c = level.get_child(ci)
			if c is Level:
				loaded_level = c
				break


func load_level(node: Level):
	if loaded_level:
		unload_level()
	
	level.add_child(node)


func load_level_by_scene(scene: PackedScene):
	var n = scene.instantiate()
	if n is Level:
		load_level(n)


func load_level_by_file(file_path: String):
	if not ResourceLoader.exists(file_path, "PackedScene"):
		return
	
	var s = load(file_path)
	load_level_by_scene(s)


func unload_level():
	level.remove_child(loaded_level)
	loaded_level.queue_free()
