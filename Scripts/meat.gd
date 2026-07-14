extends Area2D


func _on_body_entered(body):
	if body.is_in_group("player"):
		InventoryManager.add_item("meat")
		ResourceManager.add_resource("meat", 1)  
		queue_free()
