extends Node2D

@onready var player_left_score = $Scoreboard/PlayerLeftScore
@onready var player_right_score = $Scoreboard/PlayerRightScore
@onready var ball = $Ball
@onready var spike_ball_spawn_timer = $SpikeBallSpawnTimer
@onready var screen_size = Vector2(get_viewport_rect().size)

var _player_left_score : float = 0
var _player_right_score : float = 0
var spike_ball_x : float = 0.0
var spike_ball_y : float = 0.0
var powerup_icon_array = []
var ice_spike_icon = null

const ICE_SPIKE = preload("res://Scenes/ice_spike.tscn") # SPIKE BALL INITIALIZATION
const POWER_UP_ICON = preload("res://Scenes/PowerUpIcon.tscn")
const BALL_INITIAL_POSITION = Vector2(576, 324)
const BALL_INITIAL_SPEED = 200
const SPIKE_BALL_SPAWN_MIN_WAIT = 3
const SPIKE_BALL_SPAWN_MAX_WAIT = 5
const SPIKE_BALL_X_MIN = 90
const SPIKE_BALL_X_MAX = 1040
const SPIKE_BALL_Y_MIN = 70
const SPIKE_BALL_Y_MAX = 615
const GET_BIGGER = preload("res://Scenes/get_bigger.tscn")
var power_used_ai = false
var power_used_player = false

var ice_spike_icon_ai = null
var ice_spike_icon_player = null

var already_got_power = false
var already_got_power_ai = false

func _ready():
	# Connect signals if needed
	spike_ball_spawn_timer.connect("timeout", Callable(self, "_on_spike_ball_spawn_timer_timeout"))

func _initialize_spike_ball():
	print("Initializing Spike Ball")
	var spike_ball = ICE_SPIKE.instantiate()
	add_child(spike_ball)
	spike_ball.name = "IceSpikeBall"
	print("Ball name: ", spike_ball.name)
	spike_ball.animated_sprite_2d.play()
	spike_ball.position = Vector2(spike_ball_x, spike_ball_y)

func _initalize_get_bigger_ball():
	print("Initializing Get Bigger Ball")
	var get_bigger_ball = GET_BIGGER.instantiate()
	add_child(get_bigger_ball)
	get_bigger_ball.name = "GetBiggerBall"
	print("Ball name: ", get_bigger_ball.name)
	get_bigger_ball.animated_sprite_2d.play()
	get_bigger_ball.position = Vector2(clamp(randf() * screen_size.x, SPIKE_BALL_X_MIN, SPIKE_BALL_X_MAX), clamp(randf() * screen_size.x, SPIKE_BALL_X_MIN, SPIKE_BALL_X_MAX))

func _increase_score(paddle: Node):
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
	ball.position = BALL_INITIAL_POSITION
	ball.speed = BALL_INITIAL_SPEED

func _on_ball_hand_over(paddle: Node):
	_increase_score(paddle)
	_restart_game()

func _on_spike_ball_spawn_timer_timeout():
	spike_ball_x = clamp(randf() * screen_size.x, SPIKE_BALL_X_MIN, SPIKE_BALL_X_MAX)
	spike_ball_y = clamp(randf() * screen_size.y, SPIKE_BALL_Y_MIN, SPIKE_BALL_Y_MAX)
	print("spike_ball_x:", spike_ball_x)
	spike_ball_spawn_timer.wait_time = randf_range(SPIKE_BALL_SPAWN_MIN_WAIT, SPIKE_BALL_SPAWN_MAX_WAIT)
	print(spike_ball_spawn_timer.wait_time)
	_initialize_spike_ball()
	_initalize_get_bigger_ball()

func _on_player_right_power_used():
	print("PLAYER POWER USED BRO")
	already_got_power = false
	if ice_spike_icon != null:
		ice_spike_icon.queue_free()


func _on_player_right_player_ice_spike_ready(spike_ball):
	if not already_got_power:
		print("PLAYER ICE SPIKE READY")
		spike_ball.queue_free()
		ice_spike_icon = POWER_UP_ICON.instantiate()
		add_child(ice_spike_icon)
		ice_spike_icon.position = Vector2(878, 27)
	already_got_power = true


func _on_player_right_ai_ice_spike_ready(spike_ball):
	if not already_got_power_ai:
		print("AI ICE SPIKE READY")
		spike_ball.queue_free()
		ice_spike_icon_ai = POWER_UP_ICON.instantiate()
		add_child(ice_spike_icon_ai)
		ice_spike_icon_ai.position = Vector2(280, 27)
	already_got_power_ai = true
	
func _on_player_left_power_used():
	print("LEFT GUY USED HIS POWERS!!")
	already_got_power_ai = false
	if ice_spike_icon_ai != null:
		ice_spike_icon_ai.queue_free()


func _on_ball_get_bigger_ball_touched():
	pass # Replace with function body.
