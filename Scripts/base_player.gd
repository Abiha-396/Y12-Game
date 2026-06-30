extends CharacterBody2D

@export var speed = 200.0
const acceleration =100
const friction= 1000

enum {IDLE, RUN}
var state = IDLE

@onready var animation_tree= $AnimationTree
@onready var animator = $AnimationPlayer
@onready var sprite = $AnimatedSprite2D


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
		apply_movement(direction*acceleration)
	if direction.x < 0:
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false #no else, it will stay facing the last direction pressed
		#the addon is called animated sprite to animation player convertor 4.0
		
		#blend_position= direction
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
	match state:
		IDLE:
			animator.play("Idle_right")
		RUN:
			animator.play("Run_right")
	#state_machine.travel(anim_tree_state_keys[state])
	#animation_tree.set(blend_pos_paths[state],blend_position)
