extends Node2D
@onready var check_point=$Area2D
@onready var text_box=$Panel
@onready var label=$Panel/Label

func _ready() -> void:
	text_box.hide()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	text_box.show()
	label.text="Congrats, you won"
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://Scenes/end_screen.tscn")
