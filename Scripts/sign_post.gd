extends Area2D

@export var message: String = ""
@export var title: String = ""
var can_trigger: bool = true

func _on_body_entered(body: Node2D) -> void:
	if can_trigger:
		can_trigger = false
		GlobalScript.intro_requested.emit(title, message)
		await get_tree().create_timer(10.0).timeout
		can_trigger = true
