class_name Chunk extends Node2D


signal player_entered(chunk: Chunk, player: CharacterBody2D)


@onready var area: Area2D = $Area2D


func _on_body_entered(body: Node2D):
	if body.is_in_group(&"player"):
		player_entered.emit(self, body)


func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
