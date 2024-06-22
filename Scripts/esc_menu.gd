extends Control
@onready var main = $"../.."

func _ready():
	hide()
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED


func _on_button_pressed():
	print("CONTINUE BUTTON PRESSED")
	hide()
	get_tree().paused = false
	main.modulate = Color(1.0, 1.0, 1.0)


func _on_button_2_pressed():
	print("EXIT BUTTON PRESSED")
	get_tree().quit()


func _on_main_esc_pressed():
	show()
