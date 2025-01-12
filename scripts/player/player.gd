# Player script that handles basic character movement
extends CharacterBody2D

# Movement speed in pixels per second
var speed = 100

# Track last direction for idle animation
var last_direction = Vector2.DOWN

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
	update_animation(input_vector)

func update_animation(input_vector):
	# If there's no input, set the animation to idle
	if input_vector == Vector2.ZERO:
		$AnimatedSprite.play("idle_" + getInputVectorName(last_direction))
	else:
		# If there's input, set the animation to walk
		$AnimatedSprite.play("walk_" + getInputVectorName(input_vector))

	# Update the last direction for idle animation
	if input_vector != Vector2.ZERO:
		last_direction = input_vector

	# Set the animation direction based on the last direction
	$AnimatedSprite.animation = "walk_" + getInputVectorName(last_direction)


func getInputVectorName(input_vector):
	if input_vector == Vector2.UP:
		return "up"
	elif input_vector == Vector2.DOWN:
		return "down"
	elif input_vector == Vector2.LEFT:
		return "left"
	elif input_vector == Vector2.RIGHT:
		return "right"
	else:
		return ""
