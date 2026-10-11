extends Node

@onready var background = $Background
@onready var battle = $Battle
@onready var win = $Win
@onready var lose = $Lose
@onready var run = $Run
@onready var swing = $Swing

func _ready():
	background.play()
	GlobalScript.boss_defeated.connect(start_background)
	GlobalScript.game_ended.connect(_on_game_ended)

func start_battle():
	background.stop()
	battle.play()

func start_background():
	battle.stop()
	win.stop()
	lose.stop()
	if not background.playing:
		background.play()

func play_swing():
	swing.play()

func set_running(is_running: bool):
	if is_running and not run.playing:
		run.play()
	elif not is_running and run.playing:
		run.stop()

func _on_game_ended(won: bool):
	background.stop()
	battle.stop()
	run.stop()
	if won:
		win.play()
	else:
		lose.play()
