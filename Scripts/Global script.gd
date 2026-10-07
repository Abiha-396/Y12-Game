extends Node

var life: int = 5
var tree= false
var ready_for_knighthood: bool = false
signal sword_awarded
signal resource_collected(type: String, amount: int)
signal rank_changed(new_rank: String)
signal intro_requested(title: String, body: String)
signal army_unit_recruited(unit_type: String)
signal axe_picked_up
signal intro_closed
signal axe_swung(pos: Vector2)


func _process(delta: float) -> void:
	if life==0:
		get_tree().change_scene_to_file("res://Scenes/end_screen.tscn")
