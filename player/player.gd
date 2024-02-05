extends CharacterBody2D

@export var speed: int = 35

# Get movement from input
func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * speed
# Set velocity to movement direction * speed
# Move the player

func _physics_process(delta):
	handleInput()
	move_and_slide()
 
