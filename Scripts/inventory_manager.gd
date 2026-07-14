extends Node

var items: Array[String] = []

func add_item(item_name: String):
	items.append(item_name)
	inventory_updated.emit()

signal inventory_updated
