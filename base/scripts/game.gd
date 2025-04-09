## Basic functionality for a game
class_name Game extends Node


## Level parent
@onready var level: Node = $Level
## Currently loaded level, null if none
var loaded_level: Level


func _ready() -> void:
	if level.get_child_count() > 0:
		for ci in level.get_child_count():
			var c = level.get_child(ci)
			if c is Level:
				loaded_level = c
				break


## Unloads [member loaded_level] and loads node
func load_level(node: Level):
	if loaded_level:
		unload_level()
	
	loaded_level = level
	level.add_child(node)


## Same as [method load_level] but for a scene
func load_level_by_scene(scene: PackedScene):
	var n = scene.instantiate()
	if n is Level:
		load_level(n)


## Same as [method load_level] but for a file
func load_level_by_file(file_path: String):
	if not ResourceLoader.exists(file_path, "PackedScene"):
		return
	
	var s = load(file_path)
	load_level_by_scene(s)


## Reloads [member loaded_level]
func reload_level():
	if not loaded_level: return
	var fp = loaded_level.scene_file_path
	if fp.is_empty(): return
	
	load_level_by_file(fp)


## Unloads [member loaded_level]
func unload_level():
	level.remove_child(loaded_level)
	loaded_level.queue_free()
