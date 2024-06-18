extends Node2D

# This is the power up manager that manages the initalization, deinitialization
# and management of the powerups that occurs in the game.

# Signals to be emitted during the gameplay
signal get_bigger_available_left
signal get_bigger_available_right 

signal get_smaller_available_left
signal get_smaller_available_right

signal ice_spike_available_left
signal ice_spike_available_right

# Variables to decide if the ice spike power already available
var is_ice_spike_available_left : bool = false
var is_ice_spike_available_right : bool = false

# Variables to decide which player's right to get the powerup
var left_player_touched_last : bool = false
var right_player_touched_last : bool = false

# PowerUp Scenes to be Initialized
var get_bigger_ball = ("res://Scenes/get_bigger.tscn")
var get_smaller_ball = load("res://Scenes/get_smaller.tscn")
var ice_spike_ball = load("res://Scenes/ice_spike.tscn")

@onready var screen_size = Vector2(get_viewport_rect().size)

# Constant parameters
const POWERUP_SPAWN_X_MIN = 90
const POWERUP_SPAWN_X_MAX = 1040
const POWERUP_SPAWN_Y_MIN = 70
const POWERUP_SPAWN_Y_MAX = 615

func _initialize_spike_ball():
	
	var spike_ball_x = clamp(randf() * screen_size.x, POWERUP_SPAWN_X_MIN, POWERUP_SPAWN_X_MAX)
	var spike_ball_y = clamp(randf() * screen_size.y, POWERUP_SPAWN_Y_MIN, POWERUP_SPAWN_Y_MAX)
	print("Initializing Spike Ball")
	
	var spike_ball = ice_spike_ball.instantiate()
	add_child(spike_ball)
	spike_ball.name = "IceSpikeBall"
	print("Ball name: ", spike_ball.name)
	
	spike_ball.animated_sprite_2d.play()
	spike_ball.position = Vector2(spike_ball_x, spike_ball_y)
	return spike_ball
	
func _initialize_get_bigger_ball():
	
	var get_bigger_ball_x = clamp(randf() * screen_size.x, POWERUP_SPAWN_X_MIN, POWERUP_SPAWN_X_MAX)
	var get_bigger_ball_y = clamp(randf() * screen_size.y, POWERUP_SPAWN_Y_MIN, POWERUP_SPAWN_Y_MAX)
	print("Initializing Get Bigger Ball")
	
	var bigger_ball = get_bigger_ball.instantiate()
	add_child(bigger_ball)
	bigger_ball.name = "GetBiggerBall"
	print("Ball name: ", bigger_ball.name)
	
	bigger_ball.animated_sprite_2d.play()
	bigger_ball.position = Vector2(get_bigger_ball_x, get_bigger_ball_y)
	return bigger_ball
	
func _initialize_get_smaller_ball():
	
	var get_smaller_ball_x = clamp(randf() * screen_size.x, POWERUP_SPAWN_X_MIN, POWERUP_SPAWN_X_MAX)
	var get_smaller_ball_y = clamp(randf() * screen_size.y, POWERUP_SPAWN_Y_MIN, POWERUP_SPAWN_Y_MAX)
	print("Initializing Get Bigger Ball")
	
	var smaller_ball = get_smaller_ball.instantiate()
	add_child(smaller_ball)
	smaller_ball.name = "GetSmallerBall"
	print("Ball name: ", smaller_ball.name)
	
	smaller_ball.animated_sprite_2d.play()
	smaller_ball.position = Vector2(get_smaller_ball_x, get_smaller_ball_y)
	return smaller_ball


func _on_ball_get_bigger_ball_touched(ball):
	
	ball.queue_free()
	
	if right_player_touched_last:
		get_bigger_available_right.emit()
	elif left_player_touched_last:
		get_bigger_available_left.emit()


func _on_ball_get_smaller_ball_touched(ball):
	
	ball.queue_free()
	
	if right_player_touched_last:
		get_smaller_available_right.emit()
	elif left_player_touched_last:
		get_smaller_available_left.emit()


func _on_ball_ice_spike_ball_touched(ball):
	if right_player_touched_last:
		is_ice_spike_available_right = true
		if not is_ice_spike_available_right:
			ball.queue_free()
			ice_spike_available_left.emit()
			
	elif left_player_touched_last:
		is_ice_spike_available_left = true
		if not is_ice_spike_available_left:
			ball.queue_free()
			ice_spike_available_left.emit()
			
func _on_ball_bounced_from_left(ball):
	# To decide which player should get the powerup
	
	right_player_touched_last = false
	left_player_touched_last = true


func _on_ball_bounced_from_right():
	# To decide which player should get the powerup
	
	right_player_touched_last = true
	left_player_touched_last = false


func _on_spike_ball_spawn_timer_timeout():
	pass # Replace with function body.


func _on_get_bigger_ball_spawn_timer_timeout():
	pass # Replace with function body.


func _on_get_smaller_ball_spawn_timer_timeout():
	pass # Replace with function body.
