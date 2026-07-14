extends Control
@onready var sprite=$Sprite2D




func _ready() -> void:
	sprite.modulate= Color.DIM_GRAY
	GlobalScript.tree
	
func _process(delta: float) -> void:
	if GlobalScript.tree==true:
		sprite.modulate=Color.WHITE
	
	


func _on_area_2d_mouse_entered() -> void:
		InventoryManager.add_item("relic_shield")
		sprite.modulate= Color.GREEN_YELLOW
