extends Control
@onready var beginning_countdown = $"../../BeginningCountdown"

@onready var label = $GridContainer/Label
@onready var main = $"../.."
# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalVariables.left_player_score == 1:
		label.text = "LEFT WINS!"
	else:
		label.text = "RIGHT WINS!"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	print("HEYYY")
	GlobalVariables.left_player_score = 0
	GlobalVariables.right_player_score = 0
	GlobalVariables.music_progress = 0.0
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_button_2_pressed():
	print("BUTTON 2 PRESSED!")
	get_tree().quit()

