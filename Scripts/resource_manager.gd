extends Node2D
var resources = { "log": 0, "ore": 0, "meat": 0 }
var thresholds = { "log": 1, "ore": 0, "meat": 1 }
var wood_goal_reached: bool = false
var rank_up_sent: bool = false
var player: Node = null

func _ready():
	player = get_tree().get_first_node_in_group("player")
	GlobalScript.resource_collected.connect(_on_resource_collected)

func _on_resource_collected(type: String, amount: int):
	if type in resources:
		resources[type] += amount
		print("resources now: ", resources)
	if type == "log" and resources["log"] >= thresholds["log"] and not wood_goal_reached:
		wood_goal_reached = true
		GlobalScript.intro_requested.emit("Wood Goal Reached!", "Press Q to drop the axe.")
		if player:
			player.can_drop_axe = true
	_check_rank_up()

func _check_rank_up():
	if rank_up_sent:
		return
	for key in thresholds:
		if resources[key] < thresholds[key]:
			return
	rank_up_sent = true
	print("emitting rank_changed!")
	GlobalScript.ready_for_knighthood = true
	GlobalScript.intro_requested.emit("Well gathered!", "Bring your goods to the monastery.")
	GlobalScript.rank_changed.emit("Knight")
