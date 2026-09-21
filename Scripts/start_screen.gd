extends Control

@onready var textbox_container= $CanvasLayer/MarginContainer
@onready var text_label=$CanvasLayer/MarginContainer/Panel/HBoxContainer/Label

func _ready() -> void:
	pass

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/platform.tscn")


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _process(delta: float) -> void:
	pass#text_label.text="Hello world"
	
