extends Control

@onready var aim_label=$CanvasLayer/ScrollContainer/VBoxContainer/RichTextLabel

func _ready() -> void:
	aim_label.text=("Hi")
