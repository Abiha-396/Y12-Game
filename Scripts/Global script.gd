extends Node

const MAX_LIFE := 7

var life: int = MAX_LIFE
var tree = false
var ready_for_knighthood: bool = false
var invincible := false
var did_win := false
var game_over := false

signal sword_awarded
signal resource_collected(type: String, amount: int)
signal rank_changed(new_rank: String)
signal intro_requested(title: String, body: String)
signal army_unit_recruited(unit_type: String)
signal axe_picked_up
signal intro_closed
signal axe_swung(pos: Vector2)
signal boss_health_changed(hp, max_hp)
signal boss_defeated
signal player_hurt
signal game_ended(won: bool)

func _process(_delta):
	if life <= 0 and not game_over:
		end_game(false)

func damage(amount := 1):
	if invincible or game_over:
		return
	life -= amount
	player_hurt.emit()
	invincible = true
	await get_tree().create_timer(1.0).timeout
	invincible = false

func end_game(won: bool):
	if game_over:
		return
	game_over = true
	did_win = won
	print("end_game called, won: ", won)
	game_ended.emit(won)
	get_tree().paused = false
	var err = get_tree().change_scene_to_file("res://Scenes/end_screen.tscn")
	print("scene change result: ", err)

func reset():
	life = MAX_LIFE
	tree = false
	ready_for_knighthood = false
	invincible = false
	did_win = false
	game_over = false
	AudioManager.start_background()
