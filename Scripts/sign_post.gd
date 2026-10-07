extends Area2D

@export var message: String = ""
@export var title: String = ""
var can_trigger: bool = true

func _ready() -> void:
	GlobalScript.intro_requested.emit(title, message)
	await GlobalScript.intro_closed
func _on_body_entered(body: Node2D) -> void:
	if can_trigger:
		can_trigger = false
		GlobalScript.intro_requested.emit(title, message)
		
		
		can_trigger = true
