extends CharacterBody2D

@export var speed = 300.0

func _physics_process(_delta):
	# Get input for 4 or 8 directions (WASD / Arrows)
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction != Vector2.ZERO:
		velocity = direction * speed
	else:
		# Smoothly stop when no keys are pressed
		velocity = velocity.move_toward(Vector2.ZERO, speed)

	move_and_slide()
