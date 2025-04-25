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
	
	# DEBUG ONLY
	health.health_changed.connect(
		func (): print("%s was hurt, health = %s" % [get_parent().name, health.points])
	)


## Damages [member health] after applying [member damage_multiplier]
func hurt(damage: float):
	var d = damage * damage_multiplier
	health.damage(d)
