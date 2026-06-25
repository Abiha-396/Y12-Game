extends CanvasLayer

@onready var event_text = $Panel/Label
@onready var event_panel=$Panel
@onready var colour_rect=$ColorRect
@export var message: String = ""
@export var one_shot: bool = true
@export var display_duration: float = 1.0

func _ready():
	event_text.visible=false
	event_panel.visible=false
	print("ready")


func show_event_text(message: String):
	colour_rect.modulate
	get_tree().paused = true
	event_text.text = message
	event_text.visible = true
	event_panel.visible=true
	await get_tree().create_timer(display_duration).timeout
	event_text.visible = false
	event_panel.visible=false
	get_tree().paused = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	show_event_text(message)
