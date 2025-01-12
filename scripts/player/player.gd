extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@export var speed = 100

var last_direction = Vector2.DOWN

func _ready():
	# Set the player's initial animation and Z-index
	$AnimatedSprite2D.play("idle_down")
	z_index = LayerOrder.ZIndex.CHARACTERS
	
	# Sort sprites relative to their Y position
	y_sort_enabled = true

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
		last_direction = input_vector
	else:
		# If no input, stop the character
		velocity = Vector2.ZERO

	# Apply the movement using Godot's built-in physics system
	move_and_slide()
	update_animation(input_vector)

func update_animation(input_vector):
	if input_vector == Vector2.ZERO:
		# Use last_direction for idle animation
		var direction = getInputVectorName(last_direction)
		sprite.play("idle_" + direction)
	else:
		# Use current input_vector for walk animation
		var direction = getInputVectorName(input_vector)
		sprite.play("walk_" + direction)

func getInputVectorName(input_vector):
	# Handle diagonal movement by using the stronger axis
	if abs(input_vector.x) > abs(input_vector.y):
		return "right" if input_vector.x > 0 else "left"
	elif abs(input_vector.y) > 0:
		return "down" if input_vector.y > 0 else "up"
	return "down"  # Default direction
