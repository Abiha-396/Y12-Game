extends CanvasLayer

@onready var event_text = $Panel/Label
@onready var Title=$Panel/Top_label
@onready var event_panel=$Panel
@onready var colour_rect=$ColorRect
var Top_Message=""
var Message=""
#@export var message: String = ""
#@export var top_message: String = ""
@export var one_shot: bool = true
@export var display_duration: float = 1.0



func _ready():
	event_text.visible=false
	event_panel.visible=false
	colour_rect.modulate= Color("ffffff00")
	GlobalScript.intro_requested.connect(_on_intro_requested)
	





func _on_intro_requested(title:String, message: String):
	colour_rect.modulate= Color("0b0c0c6f")
	get_tree().paused = true
	event_text.text = message
	Title.text = title
	event_text.visible = true
	event_panel.visible=true
	await get_tree().create_timer(display_duration).timeout
	event_text.visible = false
	event_panel.visible=false
	get_tree().paused = false
	colour_rect.modulate= Color("ffffff00")
	
