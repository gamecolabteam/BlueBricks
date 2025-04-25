## Complementary node to [Hurtbox][br]
## Damages each hurtbox that enters it's collision shape[br]
class_name Hitbox extends Area2D


## If true this hitbox will hit hurtboxes entering it
@export var active: bool
## Should hits be continuous[br]
## If this is false hits will be dealt
## only when the hurtbox enters this hitbox
@export var continuous: bool
## The amount of damage to be dealt
@export var damage: float
## Interval in seconds between each hit
@export var interval: float
## Time since last 
var time_elapsed: float


func _on_area_entered(area: Area2D):
	if active and not continuous and area is Hurtbox:
		hit(area)


func _physics_process(delta: float) -> void:
	if continuous and time_elapsed < interval: time_elapsed += delta
	
	if active and continuous and time_elapsed >= interval:
		time_elapsed -= interval
		var dmg = damage * delta if is_zero_approx(interval) else damage
		for a in get_overlapping_areas():
			if a is Hurtbox: hit(a, dmg)


func _ready() -> void:
	monitorable = false
	collision_layer = 0
	collision_mask = 1 << 4
	area_entered.connect(_on_area_entered)


func hit(hurtbox: Hurtbox, dmg: float = damage):
	hurtbox.hurt(dmg)
