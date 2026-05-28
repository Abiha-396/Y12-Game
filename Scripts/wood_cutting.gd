extends Node2D
@onready var label=$Area2D/TextureRect/Label


func _ready() -> void:
	label.show()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	label.show()
	await get_tree().create_timer(3.0).timeout
	label.hide()
