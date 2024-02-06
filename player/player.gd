extends CharacterBody2D

@export var speed: int = 125
@export var maxHealth: int = 5
@export var knockbackPower: int = 500

@onready var animations = $AnimationPlayer
@onready var currentHealth = maxHealth

signal healthChanged

# Get movement from input
func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
# Set velocity to movement direction * speed
	velocity = moveDirection * speed
# Move the player

func updateMovement():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "down"
		if velocity.x < 0: direction = "left"
		elif velocity.x > 0: direction = "right"
		elif velocity.y < 0: direction = "up"

		animations.play("walk_" + direction)

func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print_debug(collider.name)

func _on_hurtbox_area_entered(area):
	if area.name == "hitBox":
		currentHealth -= 1
		if (currentHealth < 0):
			currentHealth = maxHealth
		healthChanged.emit(currentHealth)
	knockback(area.get_parent().velocity)

func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()

func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateMovement()
	handleCollision()
