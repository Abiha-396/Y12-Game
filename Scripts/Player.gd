extends CharacterBody2D

@export var speed = 200.0
const acceleration = 100
const friction = 1000

enum State { IDLE, RUN }
enum Rank { PAWN, KNIGHT, KING }

var state = State.IDLE
var current_rank = Rank.PAWN
var rank_prefix = "pawn"

@onready var animator = $AnimatedSprite2D/AnimationPlayer
@onready var sprite = $AnimatedSprite2D
var has_axe: bool = false
var anim_suffix: String = ""



func _ready():
	GlobalScript.rank_changed.connect(_on_rank_changed)
	GlobalScript.axe_picked_up.connect(_on_axe_picked_up)

func _physics_process(delta):
	print(anim_suffix)
	move(delta)
	animate()

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

func _on_rank_changed(new_rank: Rank) -> void:
	current_rank = new_rank
	match new_rank:
		Rank.PAWN:
			rank_prefix = "pawn"
		Rank.KNIGHT:
			rank_prefix = "lancer"
		Rank.KING:
			rank_prefix = "king"
	match state:
		State.IDLE:
			animator.play(rank_prefix + "_idle" + anim_suffix)
		State.RUN:
			animator.play(rank_prefix + "_run" + anim_suffix)
