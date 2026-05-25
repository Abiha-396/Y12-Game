extends Sprite2D
@onready var pick_up= $"."

func _on_area_2d_body_entered(body: Node2D) -> void:
	pick_up.hide()
