extends Control
@onready var relics_menu=$"Relics book/TileMapLayer"
@onready var progress_bar=$"Top-right/ProgressBar"



func _ready() -> void:
	relics_menu.hide()
	GlobalScript.life
	
	
func _process(delta: float) -> void:
	progress_bar.value=(GlobalScript.life*100)/5

func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")


func _on_quit_pressed() -> void:
	get_tree().reload_current_scene()


func _on_relics_book_pressed() -> void:
	relics_menu.show()
	print("ClIcked")


func _on_close_pressed() -> void:
	relics_menu.hide()
