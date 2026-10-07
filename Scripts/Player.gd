extends CharacterBody2D

@export var speed = 200.0
const acceleration = 100
const friction = 1000

enum State { IDLE, RUN }
enum Rank { PAWN, KNIGHT, KING }

var state = State.IDLE
var current_rank = Rank.PAWN
var rank_prefix = "pawn"
var current_tree = null

@onready var animator = $AnimatedSprite2D/AnimationPlayer
@onready var sprite = $AnimatedSprite2D
@onready var axe_range=$Axe_range
var has_axe: bool = false
var anim_suffix: String = ""
var is_swinging: bool = false




func _ready():
	print("Player ready")
	GlobalScript.rank_changed.connect(_on_rank_changed)
	GlobalScript.axe_picked_up.connect(_on_axe_picked_up)
	


	

func _physics_process(delta):
	move(delta)
	if not is_swinging:
		animate()
	if Input.is_action_just_pressed("forward_swing") and has_axe and not is_swinging:
		is_swinging = true
		animator.play(rank_prefix + "_interact" + anim_suffix)
		swing_axe()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == rank_prefix + "_interact" + anim_suffix:
		is_swinging = false

func swing_axe():
	var targets = get_tree().get_nodes_in_group("tree") + get_tree().get_nodes_in_group("sheep")
	for target in targets:
		if global_position.distance_to(target.global_position) < 100:
			target.take_hit()
	


func _on_axe_picked_up() -> void:
	has_axe = true
	anim_suffix = "_axe"
	
func move(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction == Vector2.ZERO:
		state = State.IDLE
		apply_friction(friction * delta)
	else:
		state = State.RUN
		apply_movement(direction * acceleration)

	if direction.x < 0:
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false

	move_and_slide()

func apply_friction(amount) -> void:
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func apply_movement(amount) -> void:
	velocity += amount
	velocity = velocity.limit_length(speed)

func animate() -> void:
	match state:
		State.IDLE:
			animator.play(rank_prefix + "_idle" + anim_suffix)
		State.RUN:
			animator.play(rank_prefix + "_run" + anim_suffix)

func _on_rank_changed(new_rank: String) -> void:
	print("rank changed received: ", new_rank)
	has_axe = false
	anim_suffix = ""
	is_swinging = false
	match new_rank:
		"Pawn":
			current_rank = Rank.PAWN
			rank_prefix = "pawn"
		"Knight":
			current_rank = Rank.KNIGHT
			rank_prefix = "lancer"
		"King":
			current_rank = Rank.KING
			rank_prefix = "king"
	match state:
		State.IDLE:
			animator.play(rank_prefix + "_idle" + anim_suffix)
		State.RUN:
			animator.play(rank_prefix + "_run" + anim_suffix)
