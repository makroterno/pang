extends Node2D

@onready var player_left_score = $Scoreboard/PlayerLeftScore
@onready var player_right_score = $Scoreboard/PlayerRightScore
@onready var ball = $Ball
@onready var spike_ball_spawn_timer = $Timers/SpikeBallSpawnTimer

@onready var screen_size = Vector2(get_viewport_rect().size)

var _player_left_score : float = 0
var _player_right_score : float = 0
var powerup_icon_array = []
var ice_spike_icon = null

const POWER_UP_ICON = preload("res://Scenes/PowerUpIcon.tscn")
const BALL_INITIAL_POSITION = Vector2(576, 324)
const BALL_INITIAL_SPEED = 200


var power_used_ai = false
var power_used_player = false

var ice_spike_icon_ai = null
var ice_spike_icon_player = null

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
	ball.position = BALL_INITIAL_POSITION
	ball.speed = BALL_INITIAL_SPEED
	get_tree().reload_current_scene()
	
func _on_ball_hand_over(paddle: Node):
	_increase_score(paddle)
	_restart_game()


	


