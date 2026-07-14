extends TextureRect

@export var item_name: String = ""

func _ready():
	pass
	$TooltipLabel.visible = false

func set_item(name: String, texture: Texture2D):
	item_name = name
	self.texture = texture

func _on_mouse_entered():
	$TooltipLabel.text = item_name
	$TooltipLabel.visible = true

func _on_mouse_exited():
	$TooltipLabel.visible = false
	
