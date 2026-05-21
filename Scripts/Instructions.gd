extends Label

@onready var label =$"."
@onready var skip_button =$"../../../../Skip"
@onready var panel=$"../.."
func _ready() -> void:
	label.text="Hello World!
This would be a tutorial. For now, try using AWSD or arrow keys to move"
	

func _on_skip_pressed() -> void:
	panel.hide()
	skip_button.hide()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		label.text="Hiiiiiiiii"
