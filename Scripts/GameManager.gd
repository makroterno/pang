extends Node2D
@onready var player_left_score = $Scoreboard/PlayerLeftScore
@onready var player_right_score = $Scoreboard/PlayerRightScore

@onready var ball = $Ball

var is_ice_spike_available : bool = false

var _player_left_score : float = 0
var _player_right_score : float = 0

func _handle_ice_spike_ball(spike_ball):
	spike_ball.position = Vector2(878, 27)
	spike_ball.animated_sprite_2d.stop()
	is_ice_spike_available = true

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
	ball.position = Vector2(576, 324)
	ball.speed = 200
	
	

func _on_ball_hand_over(paddle):
	_increase_score(paddle)
	_restart_game()


func _on_ball_ice_spike_ball_touched(spike_ball):
	_handle_ice_spike_ball(spike_ball)
