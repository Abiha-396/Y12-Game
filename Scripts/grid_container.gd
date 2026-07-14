extends GridContainer

@export var slot_scene: PackedScene
@export var item_textures: Dictionary = {} # item_name -> Texture2D, fill ALL possible items here

func _ready():
	InventoryManager.inventory_updated.connect(_refresh)
	_build_slots()
	_refresh()

func _build_slots():
	for item_name in item_textures.keys():
		var slot = slot_scene.instantiate()
		add_child(slot)
		slot.set_item(item_name, item_textures[item_name])

func _refresh():
	for slot in get_children():
		if slot.item_name in InventoryManager.items:
			slot.modulate = Color(1, 1, 1, 1) # full color = owned
		else:
			slot.modulate = Color(0.3, 0.3, 0.3, 1) # dark gray = locked
