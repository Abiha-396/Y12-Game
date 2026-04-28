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
	"idle",
	"run"
]
func _physics_process(delta):
	move(delta)
	animate()

func move(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction == Vector2.ZERO:
		state= IDLE
		apply_friction(friction*delta)
	else:
		state=RUN
		apply_movement(direction*acceleration*delta)
		
		blend_position= direction
	move_and_slide()
	
func apply_friction(amount) -> void:
	if velocity.length()> amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity= Vector2.ZERO
	
func apply_movement(amount) -> void:
	velocity +=amount
	velocity= velocity.limit_length (speed)
	

func animate() -> void:
	state_machine.travel(anim_tree_state_keys[state])
	animation_tree.set(blend_pos_paths[state],blend_position)
