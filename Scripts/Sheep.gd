extends CharacterBody2D
@onready var animation_player = $AnimatedSprite2D

const speed = 40 # Adjust this to match your animation pace
var runaway_direction: Vector2 = Vector2.ZERO
var is_running: bool = false
const safe_distance = 100

# Leave this empty at first. We will grab the real player node when they walk into the area.
var player_ref: Node2D = null 

func _physics_process(delta):
	if is_running:
		# 1. Move the sheep
		velocity = runaway_direction * speed
		move_and_slide() # For Godot 4
		
		# 2. Flip the sprite to look where it is running
		if velocity.x != 0:
			animation_player.flip_h = velocity.x < 0
			
		# 3. CHECK DISTANCE HERE (While it is actually running!)
		if player_ref:
			var current_distance = global_position.distance_to(player_ref.global_position)
			if current_distance >= safe_distance:
				stop_running()
	else:
		velocity = Vector2.ZERO

func stop_running() -> void:
	is_running = false
	player_ref = null # Clear the player reference so we stop tracking them
	animation_player.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	# Make sure the body entering is the player (adjust "Player" to your player's exact node name)
	if body.name == "Player" or body.is_in_group("player"):
		player_ref = body # Save the player node so _physics_process can track it
		is_running = true
		animation_player.play("running")
		
		# Calculate the direction away from the player
		var player_pos = body.global_position
		runaway_direction = global_position.direction_to(player_pos) * -1
