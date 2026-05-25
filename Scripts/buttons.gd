extends Control
@onready var relics_menu=$"Top-right/Health bar/Relics book/TextureRect"

	
func _ready() -> void:
	relics_menu.hide()

func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")


func _on_quit_pressed() -> void:
	get_tree().reload_current_scene()


func _on_relics_book_pressed() -> void:
	relics_menu.show()


func _on_close_pressed() -> void:
	relics_menu.hide()
