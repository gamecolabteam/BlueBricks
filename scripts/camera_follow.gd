class_name CameraFollow extends Camera2D


@export var max_distance: float = 32.
@export var follow_offset: Vector2
@export var speed: Vector2 = Vector2(64., 64.)
@export var target: Node2D


func _process(delta: float) -> void:
	if target:
		var p = global_position
		var tp = target.global_position + follow_offset
		
		if target is CharacterBody2D:
			tp.x += target.velocity.x * 0.66
			tp.y += target.velocity.y * 0.33
		
		var dstx = absf(tp.x - p.x)
		var dsty = absf(tp.y - p.y)
		var dltx = (dstx / max_distance) * speed.x * delta
		var dlty = (dsty / max_distance) * speed.y * delta
		
		global_position = Vector2(
			move_toward(p.x, tp.x, dltx),
			move_toward(p.y, tp.y, dlty)
			)


func _ready() -> void:
	if target:
		global_position = target.global_position
