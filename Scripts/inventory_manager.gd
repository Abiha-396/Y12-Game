extends Node
var items: Dictionary = {}
signal inventory_updated

func _ready():
	GlobalScript.resource_collected.connect(add_item)

func add_item(item_name: String, amount: int):
	items[item_name] = items.get(item_name, 0) + amount
	inventory_updated.emit()
