extends Node2D

@onready var animator = $AnimatedSprite2D/AnimationPlayer
@export var hits_required: int = 3
var hits_taken: int = 0

func take_hit():
	hits_taken += 1
	print("tree hit: ", hits_taken, "/", hits_required)
	if hits_taken >= hits_required:
		chop_down()

func chop_down():
	GlobalScript.resource_collected.emit("log", 1)
	await get_tree().create_timer(0.7).timeout
	animator.play("stump1")
