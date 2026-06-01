extends Node2D
@onready var axe=$Tool02
@onready var tree=$Tree

func _ready() -> void:
	GlobalScript.tree

func _on_area_2d_body_entered(body: Node2D) -> void:
	axe.hide();
	
	


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	tree.hide()
	GlobalScript.tree=true
