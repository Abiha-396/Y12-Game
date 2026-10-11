extends Area2D

@export var boss: Node2D
@export var gate: Node2D
var fight_started := false
var can_warn := true

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if fight_started or not body.is_in_group("player"):
		return
	if body.current_rank >= body.Rank.KNIGHT:
		fight_started = true
		AudioManager.start_battle()
		if gate:
			gate.queue_free()
		var flea = boss if boss else get_tree().get_first_node_in_group("boss")
		if flea:
			flea.start_fight()
	elif can_warn:
		can_warn = false
		GlobalScript.intro_requested.emit("Turn back!", "You need a sword to face this beast.")
		await get_tree().create_timer(3.0).timeout
		can_warn = true
