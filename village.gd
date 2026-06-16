extends Node2D

var sheep: PackedScene = preload("res://Scenes/sheep.tscn")

func _ready() -> void:
	randomize()
	spawn_sheep()

func spawn_sheep() -> void:
	var instance = sheep.instantiate() # 3. Create a copy of it
	instance.position = Vector2(1000, 4000)     # 4. Set where it appears
	add_child(instance)                       # 5. Show it on screen     
