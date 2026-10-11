extends CharacterBody2D

enum State { CHASE, WINDUP, ATTACK, RECOVER, DEAD }
@export var max_hp := 10
@export var speed := 60.0
var hp: int
var state := State.CHASE
var player: Node2D
var active := false
@onready var sprite = $AnimatedSprite2D
var charge_cooldown := 0.0
@onready var bar = $HealthBar

func _ready():
	hp = max_hp
	player = get_tree().get_first_node_in_group("player")
	$AttackArea.monitoring = false
	$AttackArea.body_entered.connect(_on_attack_hit)
	sprite.play("idle")
	bar.max_value = max_hp
	bar.value = max_hp
	bar.hide()

func start_fight():
	active = true
	player = get_tree().get_first_node_in_group("player")
	bar.show()

func _physics_process(_delta):
	charge_cooldown -= _delta
	if not active or state != State.CHASE or not player:
		return
	var to_player = player.global_position - global_position
	sprite.flip_h = to_player.x > 0
	if to_player.length() > 250 and charge_cooldown <= 0:
		charge()
	elif to_player.length() > 110:
		velocity = to_player.normalized() * speed
		move_and_slide()
		sprite.play("walk")
	else:
		velocity = Vector2.ZERO
		attack()

func attack():
	state = State.WINDUP
	sprite.play("attack")
	modulate = Color(1, 0.5, 0.5)
	await get_tree().create_timer(0.6).timeout
	if state == State.DEAD: return
	modulate = Color.WHITE
	state = State.ATTACK
	$AttackArea.monitoring = true
	await get_tree().physics_frame
	await get_tree().physics_frame
	for body in $AttackArea.get_overlapping_bodies():
		_on_attack_hit(body)
	print("strike | overlapping: ", $AttackArea.get_overlapping_bodies())
	await get_tree().create_timer(0.2).timeout
	$AttackArea.monitoring = false
	if state == State.DEAD: return
	state = State.RECOVER
	sprite.play("idle")
	await get_tree().create_timer(1.0).timeout
	if state == State.RECOVER:
		state = State.CHASE

func _on_attack_hit(body):
	if not body.is_in_group("player"):
		return
	var facing_boss = body.facing.dot(global_position - body.global_position) > 0
	if body.is_blocking and facing_boss:
		return
	GlobalScript.damage()

func take_hit(dmg := 1):
	if state == State.DEAD or not active:
		return
	hp -= dmg
	print("boss hp: ", hp)
	sprite.modulate = Color(3, 3, 3)
	create_tween().tween_property(sprite, "modulate", Color.WHITE, 0.15)
	bar.value = hp
	if hp <= max_hp / 2:
		speed = 90
	if hp <= 0:
		die()
	elif state == State.RECOVER:
		sprite.play("hurt")

func die():
	bar.hide()
	state = State.DEAD
	modulate = Color.WHITE
	$AttackArea.set_deferred("monitoring", false)
	$CollisionShape2D.set_deferred("disabled", true)
	sprite.play("death")
	await get_tree().create_timer(1.5).timeout
	GlobalScript.boss_defeated.emit()



func charge():
	state = State.WINDUP
	charge_cooldown = 5.0
	sprite.play("jump")
	modulate = Color(1, 0.5, 0.5)
	var dir = (player.global_position - global_position).normalized()
	await get_tree().create_timer(0.8).timeout
	if state == State.DEAD: return
	modulate = Color.WHITE
	state = State.ATTACK
	$AttackArea.monitoring = true
	var t := 0.0
	while t < 0.5 and state == State.ATTACK:
		velocity = dir * 450
		move_and_slide()
		t += get_physics_process_delta_time()
		await get_tree().physics_frame
	velocity = Vector2.ZERO
	$AttackArea.monitoring = false
	if state == State.DEAD: return
	state = State.RECOVER
	sprite.play("idle")
	await get_tree().create_timer(1.5).timeout
	if state == State.RECOVER:
		state = State.CHASE
