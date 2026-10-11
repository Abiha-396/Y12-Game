extends Control
@onready var relics_menu=$"Relics book/TileMapLayer"
@onready var progress_bar=$"Top-right/ProgressBar"
@onready var rank_label=$"Top-right/Current_rank"
@onready var objective_label: Label = $curret_objective

 


func _ready() -> void:
	relics_menu.hide()
	GlobalScript.life
	rank_label.text = "Current rank: Pawn"
	GlobalScript.rank_changed.connect(_on_rank_changed)
	objective_label.text = "Objective: Explore"
	GlobalScript.intro_requested.connect(_on_intro_requested)
	
func _on_rank_changed(new_rank: String) -> void:
	rank_label.text = ("Current rank: ")+ new_rank
	
	
func _process(delta: float) -> void:
	progress_bar.value=(GlobalScript.life*100)/5

func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")


func _on_quit_pressed() -> void:
	get_tree().reload_current_scene()


func _on_relics_book_pressed() -> void:
	relics_menu.show()



func _on_close_pressed() -> void:
	relics_menu.hide()
	
func _on_intro_requested(title: String, _message: String) -> void:
	objective_label.text = "Objective: " + title
