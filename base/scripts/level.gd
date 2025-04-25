## Base level
class_name Level extends Node2D


## Half of the resolution
const BASE_CENTER: Vector2 = Vector2(320., 180.)


@onready var backgrounds: Node2D = $Backgrounds
@onready var chunk_manager: ChunkManager = $Scroll/ChunkManager
@onready var player: CharacterBody2D = %Player
@onready var scroll: Node2D = $Scroll


func _physics_process(_delta: float) -> void:
	_side_scroll.call_deferred()


func _ready() -> void:
	var c = chunk_manager.center_chunk
	var sp = c.chunk.get_node(^"PlayerSpawnPosition")
	player.global_position = sp.global_position


func _side_scroll():
	var motion = player.global_position - BASE_CENTER
	player.global_position = BASE_CENTER
	
	scroll.position += -motion
	
	for bi in backgrounds.get_child_count():
		var b = backgrounds.get_child(bi) as Parallax2D
		if b:
			b.screen_offset += motion
