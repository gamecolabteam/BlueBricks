extends CharacterBody2D


@export var jump_velocity: float = 384.
@export var speed: float = 128.
@onready var sprite: AnimatedSprite2D = $Sprite
var gliding: bool


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_pressed(&"jump") and is_on_floor():
		velocity.y = -jump_velocity
	
	# Glide
	if Input.is_action_pressed(&"jump") and not is_on_floor() and velocity.y > 0.:
		sprite.play(&"glide")
		velocity.y /= 1.5
		gliding = true
	else: gliding = false
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis(&"walk_left", &"walk_right")
	if direction:
		velocity.x = direction * speed
		sprite.flip_h = direction < 0.
		if not gliding: sprite.play(&"walk")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if not gliding: sprite.play(&"idle")
	
	move_and_slide()
