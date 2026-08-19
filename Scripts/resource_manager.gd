extends Node2D

var resources = { "wood": 0, "ore": 0, "food": 0 }
var thresholds = { "wood": 10, "ore": 5, "food": 8 }
var wood_goal_reached: bool = false
var player: Node = null  # assign in _ready, e.g. get_tree().get_first_node_in_group("player")

func _ready():
	GlobalScript.resource_collected.connect(_on_resource_collected)

func _on_resource_collected(type: String, amount: int):
	_check_rank_up()

func _check_rank_up():
	for key in thresholds:
		if resources[key] < thresholds[key]:
			return
	GlobalScript.rank_changed.emit("Knight")

func add_resource(type: String, amount: int):
	resources[type] += amount
	GlobalScript.resource_collected.emit(type, resources[type])
	if type == "wood" and resources["wood"] >= thresholds["wood"] and not wood_goal_reached:
		wood_goal_reached = true
		GlobalScript.intro_requested.emit("Wood Goal Reached!", "Press Q to drop the axe.")
		if player:
			player.can_drop_axe = true
