extends GridContainer

@export var slot_scene: PackedScene 

func _ready():
	InventoryManager.inventory_updated.connect(_refresh)
	_refresh()




func _refresh():
	for slot in get_children():
		if slot.item_name in InventoryManager.items:
			slot.modulate = Color(1, 1, 1, 1)
		else:
			slot.modulate = Color(0.3, 0.3, 0.3, 1)
