extends Node2D

var resources = { "wood": 0, "ore": 0, "food": 0 }
var thresholds = { "wood": 10, "ore": 5, "food": 8 }

func _ready():
	GlobalScript.resource_collected.connect(_on_resource_collected)

func _on_resource_collected(type: String, amount: int):
	resources[type] += amount
	_check_rank_up()

func _check_rank_up():
	for key in thresholds:
		if resources[key] < thresholds[key]:
			return
   GlobalScript.rank_changed.emit("Knight")
