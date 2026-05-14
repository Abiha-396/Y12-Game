extends Node2D

func _ready() -> void:
	GlobalScript.life

func _on_area_2d_body_entered(body: Node2D) -> void:
	GlobalScript.life-=1
	print("Ouch")
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	GlobalScript.life-=1
	print("Ouch")
