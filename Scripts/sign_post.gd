extends Area2D


# Define the custom signal with a text parameter
signal message_sent(message: String)
@export var message=""
@export var title=""
func send_text():
	message_sent.emit(title,message)
