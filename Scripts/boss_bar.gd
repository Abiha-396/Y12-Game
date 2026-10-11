extends ProgressBar

func _ready():
	max_value = 12
	value = 12
	GlobalScript.boss_health_changed.connect(_on_boss_health_changed)

func _on_boss_health_changed(hp, max_hp):
	max_value = max_hp
	value = hp
