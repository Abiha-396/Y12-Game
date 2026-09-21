extends Area2D

var briefed := false
var awarded := false

@onready var sword = $SwordPickup

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if awarded or not body.is_in_group("player"):
		return
	if GlobalScript.ready_for_knighthood:
		awarded = true
		GlobalScript.intro_requested.emit("Well earned!", "Take this sword, Knight.")
		await GlobalScript.intro_closed
		sword.show()
		sword.set_deferred("monitoring", true)
	elif not briefed:
		briefed = true
		GlobalScript.intro_requested.emit("The Monastery", "Bring me a log and 3 pieces of meat, and I will reward you.")
