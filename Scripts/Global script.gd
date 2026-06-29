extends Node

var life: int = 5
var tree= false
signal resource_collected(type: String, amount: int)
signal rank_changed(new_rank: String)
signal intro_requested(title: String, body: String)
signal army_unit_recruited(unit_type: String)

func _process(delta: float) -> void:
	if life==0:
		get_tree().change_scene_to_file("res://Scenes/end_screen.tscn")
