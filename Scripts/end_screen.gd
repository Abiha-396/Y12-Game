extends Control
@onready var label=$Label

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")


func _ready() -> void:
	GlobalScript.life
	
func _process(delta: float) -> void:
	if GlobalScript.life==0:
		label.text="Try again"
	else:
		label.text="you won"
