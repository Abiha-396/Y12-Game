extends Node2D

@export var respawn_time := 60.0
@export var max_start_delay := 30.0

@onready var sprite: AnimatedSprite2D = $Rock
@onready var shape: CollisionShape2D = find_child("CollisionShape2D", true, false)

var started := false

func _ready() -> void:
	sprite.hide()
	shape.set_deferred("disabled", true)
	GlobalScript.axe_picked_up.connect(_on_axe_picked_up)

func _on_axe_picked_up() -> void:
	if started:
		return
	started = true
	await get_tree().create_timer(randf() * max_start_delay).timeout
	burn_cycle()

func burn_cycle() -> void:
	while true:
		sprite.show()
		shape.set_deferred("disabled", false)
		sprite.play("fire%d" % randi_range(1, 3))
		await sprite.animation_finished
		sprite.hide()
		shape.set_deferred("disabled", true)
		await get_tree().create_timer(respawn_time * randf_range(0.8, 1.2)).timeout

func _on_area_2d_body_entered(body: Node2D) -> void:
	GlobalScript.life -= 1

func _on_area_2d_area_entered(area: Area2D) -> void:
	GlobalScript.life -= 1
