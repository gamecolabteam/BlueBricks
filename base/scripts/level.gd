## Base level
class_name Level extends Node2D


## Half of the resolution
const BASE_CENTER: Vector2 = Vector2(320., 180.)


@onready var background: Parallax2D = %Background
@onready var chunk_manager: ChunkManager = $ChunkManager
@onready var player: CharacterBody2D = %Player


func _physics_process(_delta: float) -> void:
	_side_scroll.call_deferred()


func _side_scroll():
	var motion = player.global_position - BASE_CENTER
	player.global_position = BASE_CENTER
	
	chunk_manager.global_position += -motion
	
	background.scroll_offset += -motion
