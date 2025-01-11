# Player script that handles basic character movement
extends CharacterBody2D

# Movement speed in pixels per second
var speed = 100

# Called every physics frame to handle movement
func _physics_process(_delta):
	# Get input for both horizontal and vertical axes
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")

	# If there's input, normalize it to prevent faster diagonal movement
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		velocity = input_vector * speed
	else:
		# If no input, stop the character
		velocity = Vector2.ZERO

	# Apply the movement using Godot's built-in physics system
	move_and_slide()
