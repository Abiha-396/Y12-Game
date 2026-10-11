extends ProgressBar

func _ready():
	max_value = GlobalScript.MAX_LIFE
	value = GlobalScript.life

func _process(_delta):
	value = GlobalScript.life
