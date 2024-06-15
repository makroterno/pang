extends Node2D
@onready var player_left_score = $Scoreboard/PlayerLeftScore
@onready var player_right_score = $Scoreboard/PlayerRightScore

@onready var ball = $Ball

signal ice_spike_retrieved

var _player_left_score : float = 0
var _player_right_score : float = 0




func _increase_score(paddle):
	print("Ball reached the other side")
	if paddle.name == "Left":
		_player_right_score += 1
		player_right_score.text = str(_player_right_score)
		print("Left")
	else:
		_player_left_score += 1
		player_left_score.text = str(_player_left_score)
		print("Right")
		
func _restart_game():
	# Do not restart the WHOLE scene. There is no need for that.
	ball.position = Vector2(576, 324)
	ball.speed = 200
	
func _on_ball_hand_over(paddle):
	_increase_score(paddle)
	_restart_game()

