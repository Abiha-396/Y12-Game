extends AnimatedSprite2D
@onready var monk=$AnimationPlayer
@onready var map=$Panel
@onready var map_text=$Panel/Label
func _ready() -> void:
	map.hide()
	
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	monk.play("Getting_out")
	await monk.animation_finished  
	map.show()
	map_text.text="Go to the village and bring back gold, meat and trees"
