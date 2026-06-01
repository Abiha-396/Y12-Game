extends Node

var life: int = 3
var tree= false

func _process(delta: float) -> void:
	if life==0:
		get_tree().change_scene_to_file("res://Scenes/end_screen.tscn")
