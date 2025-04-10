class_name CameraFollow extends Camera2D


@export var max_distance: float = 32.
@export var speed: float = 64.
@export var target: Node2D


func _process(delta: float) -> void:
	if target:
		var tp = target.global_position
		if target is CharacterBody2D:
			tp.x += target.velocity.x * 0.66
			tp.y += target.velocity.y * 0.33
		var dst = global_position.distance_to(tp)
		var dlt = (dst / max_distance) * speed * delta
		global_position = global_position.move_toward(tp, dlt)


func _ready() -> void:
	if target:
		global_position = target.global_position
