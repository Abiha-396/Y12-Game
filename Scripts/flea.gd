extends CharacterBody2D


const SPEED = -250
const JUMP_VELOCITY = -400.0

func _ready():
	velocity.x=0

	
func _physics_process(delta):
	velocity.x = SPEED
	

	move_and_slide()


func _on_area_2d_body_entered(body):
	print(body)
	if body is CharacterBody2D:
		body.hide()
		await get_tree().create_timer(0.5).timeout
		print("Flea is dead")
