extends Camera2D

func _ready():
	GlobalScript.player_hurt.connect(shake)

func shake(strength := 6.0, duration := 0.25):
	var tw = create_tween()
	for i in 6:
		tw.tween_property(self, "offset", Vector2(randf_range(-strength, strength), randf_range(-strength, strength)), duration / 7)
	tw.tween_property(self, "offset", Vector2.ZERO, duration / 7)
