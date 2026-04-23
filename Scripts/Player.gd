extends CharacterBody2D

@export var speed = 300.0
const acceleration =800
const friction=500

enum {IDLE, RUN}
var state = IDLE

@onready var animation_tree= $AnimationTree
@onready var state_machine= animation_tree["parameters/playback"]

var blend_position : Vector2 = Vector2.ZERO
var blend_pos_paths = [
	"parameters/Idle /Idle_bs2D/blend_position",
	"parameters/Run/Run_bs2D/blend_position"
]

var anim_tree_state_keys = [
	"Idle",
	"Run "
]
func _physics_process(_delta):
	# Get input for 4 or 8 directions (WASD / Arrows)
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction == Vector2.ZERO:
		state= IDLE
	
	
	if direction != Vector2.ZERO:
		velocity = direction * speed
	else:
		# Smoothly stop when no keys are pressed
		velocity = velocity.move_toward(Vector2.ZERO, speed)

	move_and_slide()
