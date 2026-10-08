extends Area2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GlobalScript.rank_changed.emit("Knight")
		queue_free()
		GlobalScript.resource_collected.emit("Sword", 1)
		GlobalScript.rank_changed.emit("Knight")
