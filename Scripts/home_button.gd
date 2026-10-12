extends Button


func _on_pressed() -> void:
	GlobalScript.reset()
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")
