extends Node2D

@export var start_offset := Vector2(0, 1000)
@export var run_time := 2.0
@onready var s: AnimatedSprite2D = $AnimatedSprite2D

func play_anim(wanted: String):
	for a in s.sprite_frames.get_animation_names():
		if a.to_lower() == wanted.to_lower():
			s.play(a)
			return
	print("villager missing animation: ", wanted, " | available: ", s.sprite_frames.get_animation_names())

func cheer_in():
	var target := position
	await get_tree().create_timer(randf() * 0.8).timeout
	position = target + start_offset
	s.flip_h = start_offset.x > 0
	show()
	play_anim("run")
	create_tween().tween_property(self, "position", target, run_time)
	await get_tree().create_timer(run_time + 0.05).timeout
	s.flip_h = false
	play_anim("cheer")
