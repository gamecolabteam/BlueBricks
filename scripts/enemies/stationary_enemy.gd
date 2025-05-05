extends CharacterBody2D


@export var health: Health
@onready var hitbox: Hitbox = $Hitbox
@onready var sprite: AnimatedSprite2D = $Sprite


func _on_health_damaged():
	if sprite.is_playing() and sprite.animation == &"hurt":
		sprite.stop()
	sprite.play(&"hurt")
	hitbox.active = false


func _on_health_depleted():
	sprite.play(&"death")
	hitbox.active = false


func _on_sprite_anim_finished():
	if sprite.animation == &"hurt":
		sprite.play(&"idle")
		hitbox.active = true
	elif sprite.animation == &"death":
		queue_free()


func _ready() -> void:
	health.damaged.connect(_on_health_damaged)
	health.depleted.connect(_on_health_depleted)
	sprite.animation_finished.connect(_on_sprite_anim_finished)
	sprite.play(&"idle")
