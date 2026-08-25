extends CharacterBody2D
@onready var animation_player = $AnimatedSprite2D
const speed = 40
var runaway_direction: Vector2 = Vector2.ZERO
var is_running: bool = false
var is_dying: bool = false
const safe_distance = 200
var player_ref: Node2D = null


func _physics_process(delta):
	if is_dying:
		return
	if is_running:
		velocity = runaway_direction * speed
		animation_player.play("running")
		move_and_slide()
		if velocity.x != 0:
			animation_player.flip_h = velocity.x < 0
		if player_ref:
			var current_distance = global_position.distance_to(player_ref.global_position)
			if current_distance >= safe_distance:
				stop_running()
	else:
		velocity = Vector2.ZERO

func stop_running() -> void:
	is_running = false
	player_ref = null
	animation_player.play("grazing")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" or body.is_in_group("player"):
		player_ref = body
		is_running = true
		var player_pos = body.global_position
		runaway_direction = global_position.direction_to(player_pos) * -1

func _on_catch_area_body_entered(body: Node2D) -> void:
	if body.name == "Player" or body.is_in_group("player") and not is_dying:
		is_dying = true
		is_running = false
		velocity = Vector2.ZERO
		$AnimatedSprite2D/AnimationPlayer.play("death")
		await animation_player.animation_finished
		_turn_into_meat()
		queue_free()
		

func _turn_into_meat() -> void:
	var meat = preload("res://Scenes/meat.tscn").instantiate()
	meat.global_position = global_position
	get_tree().current_scene.add_child(meat) 

	
