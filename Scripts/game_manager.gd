extends Node2D

@onready var player_left_score = $Scoreboard/PlayerLeftScore
@onready var player_right_score = $Scoreboard/PlayerRightScore
@onready var ball = $Ball
@onready var spike_ball_spawn_timer = $Timers/SpikeBallSpawnTimer
@onready var screen_size = Vector2(get_viewport_rect().size)
@onready var audio_stream_player_2d = $MainMusic


const POWER_UP_ICON = preload("res://Scenes/PowerUpIcon.tscn")

signal esc_pressed
signal right_wins
signal left_wins

var go = false

func _ready():
	get_tree().paused = true
	audio_stream_player_2d.play(GlobalVariables.music_progress)

	player_right_score.text = str(GlobalVariables.right_player_score)
	player_left_score.text = str(GlobalVariables.left_player_score)
	
func _process(delta):
	if Input.is_action_just_pressed("exit_game"):
			get_tree().paused = true
			esc_pressed.emit()
			modulate = Color(0.3, 0.3, 0.3)

func _increase_score(paddle: Node):

	if paddle.name == "Left":
		GlobalVariables.right_player_score += 1
		player_right_score.text = str(GlobalVariables.right_player_score)

	else:
		GlobalVariables.left_player_score += 1
		player_left_score.text = str(GlobalVariables.left_player_score)
	
	if GlobalVariables.right_player_score == 1:
		right_wins.emit()
		
	elif GlobalVariables.left_player_score == 1:
		left_wins.emit()

func _restart_game():
	GlobalVariables.music_progress = audio_stream_player_2d.get_playback_position()
	if not go:
		get_tree().reload_current_scene()
	
func _on_ball_hand_over(paddle: Node):
	_increase_score(paddle)
	_restart_game()

func _on_right_wins():
	get_tree().change_scene_to_file("res://Scenes/on_someone_wins.tscn")
	go = true
func _on_left_wins():
	get_tree().change_scene_to_file("res://Scenes/on_someone_wins.tscn")
	go = true

