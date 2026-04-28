# Get input for 4 or 8 directions (WASD / Arrows)
	#var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	#if direction == Vector2.ZERO:
		#state= IDLE
	
	
	#if direction != Vector2.ZERO:
		#velocity = direction * speed
	#else:
		# Smoothly stop when no keys are pressed
		#velocity = velocity.move_toward(Vector2.ZERO, speed)
