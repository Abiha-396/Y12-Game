extends Node2D

@onready var animator = $AnimatedSprite2D/AnimationPlayer
@export var hits_required: int = 3
var hits_taken: int = 0
var variant: int


func _ready() -> void:
	variant = randi_range(1, 4)
	animator.play("tree%d" % variant) 

func take_hit():
	hits_taken += 1
	print("tree hit: ", hits_taken, "/", hits_required)
	if hits_taken >= hits_required:
		chop_down()

func chop_down():
	animator.play("fall%d" % variant)
	GlobalScript.resource_collected.emit("log", 1)
	await get_tree().create_timer(0.7).timeout
	animator.play("stump%d" % variant) 
