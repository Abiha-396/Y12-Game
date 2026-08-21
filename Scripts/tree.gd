extends Node2D

@onready var animator = $AnimatedSprite2D/AnimationPlayer
@export var hits_required: int = 3
var hits_taken: int = 0

func take_hit():
	hits_taken += 1
	if hits_taken >= hits_required:
		chop_down()

func chop_down():
	animator.play("chopped") # or swap texture/sprite frame
# spawn wood pickup, disable further hits, etc.
