extends Control
@onready var label = $Label

func _ready():
	if GlobalScript.did_win:
		label.text = "Long live the King!"
	else:
		label.text = "You have fallen..."
	label.modulate.a = 0.0
	create_tween().tween_property(label, "modulate:a", 1.0, 1.5)
