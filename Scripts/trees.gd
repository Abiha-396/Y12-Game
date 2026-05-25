extends Node2D
@onready var axe=$Tool02

func _on_area_2d_body_entered(body: Node2D) -> void:
	axe.hide();
	
	
