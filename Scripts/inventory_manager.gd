extends Node
var items: Dictionary = {} # item_name -> count
signal inventory_updated

func _ready():
	GlobalScript.resource_collected.connect(add_item)

func add_item(item_name: String, amount: int):
	items[item_name] = items.get(item_name, 0) + amount
	print("items now: ", items)
	inventory_updated.emit()
