class_name Level extends Node2D


## Half of the resolution
const BASE_CENTER: Vector2 = Vector2(320., 180.)


@onready var background: Parallax2D = %Background
@onready var level: Node2D = %Level
@onready var player: CharacterBody2D = %Player


func _physics_process(_delta: float) -> void:
	side_scroll.call_deferred()


func side_scroll():
	var motion = player.global_position - BASE_CENTER
	player.global_position = BASE_CENTER
	
	level.global_position += -motion
	
	background.scroll_offset += -motion
