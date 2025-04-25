## Adds a physical presence that can be damaged
class_name Hurtbox extends Area2D


## Multiplies the damage inside of [method hurt]
@export var damage_multiplier: float
## The data [Health] object
@export var health: Health


func _ready() -> void:
	monitoring = false
	collision_layer = 1 << 4
	collision_mask = 0


## Damages [member health] after applying [member damage_multiplier]
func hurt(damage: float):
	var d = damage * damage_multiplier
	health.damage(d)
