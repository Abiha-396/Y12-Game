extends Node

@onready var background = $Background
@onready var battle = $Battle
@onready var win = $Win
@onready var lose = $Lose
@onready var run = $Run
@onready var swing = $Swing
@onready var panel_open = $PanelOpen
@onready var panel_close = $PanelClose


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	GlobalScript.intro_requested.connect(_on_panel_open)
	GlobalScript.intro_closed.connect(_on_panel_close)
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
	print("playing: ", swing.playing, " | paused: ", swing.stream_paused, " | master mute: ", AudioServer.is_bus_mute(0), " | master db: ", AudioServer.get_bus_volume_db(0))

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
		
func _on_panel_open(_title, _body):
	print("panel sound called | stream: ", panel_open.stream)
	panel_open.play()
	create_tween().tween_property(background, "volume_db", -18.0, 0.3)   # duck the music

func _on_panel_close():
	panel_close.play()
	create_tween().tween_property(background, "volume_db", -10.0, 0.5)   # bring it back
