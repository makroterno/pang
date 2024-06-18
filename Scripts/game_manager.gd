extends Node2D

@onready var player_left_score = $Scoreboard/PlayerLeftScore
@onready var player_right_score = $Scoreboard/PlayerRightScore
@onready var ball = $Ball
@onready var spike_ball_spawn_timer = $Timers/SpikeBallSpawnTimer
@onready var screen_size = Vector2(get_viewport_rect().size)


const POWER_UP_ICON = preload("res://Scenes/PowerUpIcon.tscn")


func _ready():
	player_right_score.text = str(GlobalVariables.right_player_score)
	player_left_score.text = str(GlobalVariables.left_player_score)

func _increase_score(paddle: Node):

	if paddle.name == "Left":
		GlobalVariables.right_player_score += 1
		player_right_score.text = str(GlobalVariables.right_player_score)

	else:
		GlobalVariables.left_player_score += 1
		player_left_score.text = str(GlobalVariables.left_player_score)

func _restart_game():
	# Do not restart the WHOLE scene. There is no need for that.
	get_tree().reload_current_scene()
	
func _on_ball_hand_over(paddle: Node):
	_increase_score(paddle)
	_restart_game()


