extends Area2D

@export var villagers: Array[Node2D]
@export var skip_boss_check := false   # tick this for testing only
var boss_beaten := false
var done := false
var can_warn := true

func _ready():
	body_entered.connect(_on_body_entered)
	GlobalScript.boss_defeated.connect(_on_boss_defeated)

func _on_boss_defeated():
	boss_beaten = true
	GlobalScript.intro_requested.emit("The beast has fallen!", "Head to the castle to claim your crown.")

func _on_body_entered(body):
	print("castle touched by: ", body.name, " | boss_beaten: ", boss_beaten, " | skip: ", skip_boss_check)
	if done or not body.is_in_group("player"):
		return
	if not boss_beaten and not skip_boss_check:
		if can_warn:
			can_warn = false
			GlobalScript.intro_requested.emit("Not yet...", "A beast still guards the kingdom.")
			await get_tree().create_timer(3.0).timeout
			can_warn = true
		return
	done = true
	print("celebration started")
	GlobalScript.rank_changed.emit("King")        # crowning, with your existing glow effect
	await get_tree().create_timer(1.2).timeout
	GlobalScript.intro_requested.emit("Long live the King!", "The kingdom is yours.")
	for x in [-200, -100, 0, 100, 200]:
		spawn_confetti(global_position + Vector2(x, -60))
	for v in villagers:
		v.cheer_in()
	await get_tree().create_timer(7.0).timeout
	GlobalScript.end_game(true)


func spawn_confetti(pos: Vector2):
	var p := CPUParticles2D.new()
	add_child(p)
	p.z_index = 100
	p.global_position = pos
	p.one_shot = true
	p.amount = 80
	p.lifetime = 2.5
	p.explosiveness = 0.9
	p.direction = Vector2.UP
	p.spread = 70.0
	p.initial_velocity_min = 250.0
	p.initial_velocity_max = 450.0
	p.gravity = Vector2(0, 500)
	p.scale_amount_min = 4.0
	p.scale_amount_max = 8.0
	var g := Gradient.new()
	g.set_color(0, Color.RED)
	g.set_color(1, Color.CYAN)
	g.add_point(0.5, Color.GOLD)
	p.color_initial_ramp = g
	p.emitting = true
