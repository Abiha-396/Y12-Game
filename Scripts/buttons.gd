extends Control


	


func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")


func _on_quit_pressed() -> void:
	get_tree().reload_current_scene()
