extends Node2D
@onready var player_left_score = $Scoreboard/PlayerLeftScore
@onready var player_right_score = $Scoreboard/PlayerRightScore



var _player_left_score : float = 0
var _player_right_score : float = 0

func _increase_score(area):
	print("Ball reached the other side")
	if area.name == "Left":
		_player_right_score += 1
		player_right_score.text = str(_player_right_score)
		print("Left")
	else:
		_player_left_score += 1
		player_left_score.text = str(_player_left_score)
		print("Right")

func _on_ball_hand_over(area):
	_increase_score(area)
