extends Area2D

@export var message: String = ""
@export var title: String = ""
@export var show_on_start: bool = false  # tick this on the welcome signpost only
var can_trigger: bool = true

func _ready() -> void:
	if show_on_start:
		GlobalScript.intro_requested.emit.call_deferred(title, message)

func _on_body_entered(body: Node2D) -> void:
	if not can_trigger:
		return
	can_trigger = false
	GlobalScript.intro_requested.emit(title, message)
	await GlobalScript.intro_closed
	can_trigger = true
