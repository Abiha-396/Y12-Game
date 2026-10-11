extends Area2D

@export var inventory_item: String = "Sword"
@export var new_rank: String = "Knight"
@export_enum("Pawn", "Knight") var required_rank: int = 0
@export var appear_after_boss := false
var collected := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	if appear_after_boss:
		hide()
		monitoring = false
		GlobalScript.boss_defeated.connect(_appear)

func _appear() -> void:
	show()
	set_deferred("monitoring", true)
	GlobalScript.intro_requested.emit("The beast has fallen!", "Take the shield of the king.")

func _on_body_entered(body: Node2D) -> void:
	print("touched by: ", body.name)
	if collected or not body.is_in_group("player"):
		return
	if body.current_rank != required_rank:
		return
	collected = true
	GlobalScript.resource_collected.emit(inventory_item, 1)
	GlobalScript.rank_changed.emit(new_rank)
	queue_free()
