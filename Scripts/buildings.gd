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
		GlobalScript.intro_requested.emit("The last battle", "Well earned.\nTake this sword, Knight.\nFind the dark flea that takes no mercy, and free us from the evil.\nThe one who beheads the monster shall thus be our King.")
		await GlobalScript.intro_closed
		sword.show()
		sword.set_deferred("monitoring", true)
	
		
	elif not briefed:
		briefed = true
		GlobalScript.intro_requested.emit("The Monastery", "Bring me a dozen logs and 6 pieces of meat, and I will reward you.\nThe relics book icon on the top-left corner will help you keep track of your belongings, so use it.\n If you get stuck, ask the villagers for help, they're a lovely bunch.")
