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
var facing := Vector2.DOWN

@onready var animator = $AnimatedSprite2D/AnimationPlayer
@onready var sprite = $AnimatedSprite2D
@onready var axe_range=$Axe_range
@onready var base_scale: Vector2 = sprite.scale
var has_axe: bool = false
var anim_suffix: String = ""
var is_swinging: bool = false
var is_blocking := false
@export var start_as_knight := false



func _ready():
	if start_as_knight:
		_on_rank_changed("Knight")
	GlobalScript.rank_changed.connect(_play_transition)
	GlobalScript.axe_picked_up.connect(_on_axe_picked_up)
	GlobalScript.player_hurt.connect(_on_hurt)
	


	

func _physics_process(delta):
	is_blocking = current_rank == Rank.KNIGHT and Input.is_action_pressed("block") and not is_swinging
	if is_blocking:
		velocity = Vector2.ZERO
		AudioManager.set_running(false)
		var d = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if d != Vector2.ZERO:
			facing = d
		play_lancer("defence")
		return
	move(delta)
	if not is_swinging:
		animate()
	if Input.is_action_just_pressed("forward_swing") and not is_swinging:
		if current_rank == Rank.KNIGHT:
			knight_attack()
		elif has_axe:
			is_swinging = true
			animator.play(rank_prefix + "_interact" + anim_suffix)
			swing_axe()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == rank_prefix + "_interact" + anim_suffix:
		is_swinging = false

func swing_axe():
	AudioManager.play_swing()
	var targets = get_tree().get_nodes_in_group("tree") + get_tree().get_nodes_in_group("sheep")
	for target in targets:
		if global_position.distance_to(target.global_position) < 100:
			target.take_hit()
	


func _on_axe_picked_up() -> void:
	has_axe = true
	anim_suffix = "_axe"
	
func move(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction != Vector2.ZERO:
		facing = direction
	if direction == Vector2.ZERO:
		state = State.IDLE
		AudioManager.set_running(false)
		apply_friction(friction * delta)
	else:
		state = State.RUN
		AudioManager.set_running(true)
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
			play_anim(rank_prefix + "_idle" + anim_suffix)
		State.RUN:
			play_anim(rank_prefix + "_run" + anim_suffix)
			
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
	animate()
			
func _play_transition(new_rank: String) -> void:
	set_physics_process(false)
	velocity = Vector2.ZERO
	var tw := create_tween()
	tw.tween_property(sprite, "modulate", Color(3, 3, 3), 0.4)
	tw.tween_callback(_on_rank_changed.bind(new_rank))
	tw.tween_property(sprite, "scale", base_scale * 1.4, 0.15)
	tw.tween_property(sprite, "scale", base_scale, 0.15)
	tw.parallel().tween_property(sprite, "modulate", Color.WHITE, 0.3)
	tw.tween_callback(set_physics_process.bind(true))
	
	
func play_lancer(kind: String):
	var dir = "right"
	if abs(facing.y) > abs(facing.x):
		dir = "down" if facing.y > 0 else "up"
	var anim = "lancer_%s_%s" % [dir, kind]
	if animator.has_animation(anim):
		animator.play(anim)
	else:
		animator.stop()
		sprite.play(anim)

func knight_attack():
	AudioManager.play_swing()
	is_swinging = true
	play_lancer("attack")
	await get_tree().create_timer(0.2).timeout
	for boss in get_tree().get_nodes_in_group("boss"):
		if global_position.distance_to(boss.global_position) < 150:
			boss.take_hit()
	await get_tree().create_timer(0.3).timeout
	is_swinging = false


func _on_hurt():
	var tw = create_tween()
	for i in 4:
		tw.tween_property(sprite, "modulate:a", 0.3, 0.1)
		tw.tween_property(sprite, "modulate:a", 1.0, 0.1)
		
		
func play_anim(anim: String) -> void:
	if animator.has_animation(anim):
		animator.play(anim)
		return
	if sprite.sprite_frames.has_animation(anim):
		animator.stop()
		sprite.play(anim)
		return
	var run_anim = anim.replace("_idle", "_run")
	if sprite.sprite_frames.has_animation(run_anim):
		animator.stop()
		sprite.play(run_anim)
		sprite.pause()
		sprite.frame = 0
	else:
		print("missing animation: ", anim)
