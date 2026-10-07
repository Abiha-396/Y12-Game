extends CharacterBody2D

@onready var animation_player = $AnimatedSprite2D
@onready var death_player: AnimationPlayer = $AnimatedSprite2D/AnimationPlayer

const speed = 70
const safe_distance = 200

var runaway_direction: Vector2 = Vector2.ZERO
var is_running: bool = false
var is_dying: bool = false
var player_ref: Node2D = null

func _ready() -> void:
	add_to_group("sheep")

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
		runaway_direction = global_position.direction_to(body.global_position) * -1

func take_hit() -> void:
	_die()

func _die() -> void:
	if is_dying:
		return
	is_dying = true
	is_running = false
	velocity = Vector2.ZERO
	death_player.play("death")
	await death_player.animation_finished
	_turn_into_meat()
	queue_free()

func _turn_into_meat() -> void:
	var meat = preload("res://Scenes/meat.tscn").instantiate()
	get_tree().current_scene.add_child(meat)
	meat.global_position = global_position
