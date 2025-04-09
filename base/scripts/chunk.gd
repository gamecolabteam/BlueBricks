## Base Chunk
@tool
class_name Chunk extends Node2D


## Size of the chunk bounds.
## Only used as reference.
@export var size: Vector2 = Vector2(640., 360.):
	set(value):
		size = value
		queue_redraw()


func _draw() -> void:
	var r = Rect2(-size / 2., size)
	draw_rect(r, Color.RED, false, 1.)
