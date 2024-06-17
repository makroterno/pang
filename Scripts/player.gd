extends Node2D
class_name Player
signal power_used
@onready var player_left = $"../PlayerLeft"

@export var sprite : Texture2D
@export var ball_direction = Vector2(1, 0)
@export var control_up : String = ""
@export var control_down : String = ""

@onready var main = $"../.."
@onready var cpu_particles_2d = $CPUParticles2D
@onready var y_size = get_viewport_rect().size.y # May be buggy if there will be a size change since this only initalizes once
@onready var sprite_2d = $Sprite2D

var velocity : float = 500.0
var _ball_direction = Vector2(1, 0)
var paddle_direction : int = 1
var is_ice_spike_touched = false
var is_ice_spike_touched_from_right = false
var ai_ice_spike_touched = false
var is_freezed = false
signal ai_ice_spike_ready
signal player_ice_spike_ready
signal ai_get_bigger
signal player_get_bigger
signal ai_get_smaller
signal player_get_smaller

const ICE_SPIKE_PROJECTILE = preload("res://Scenes/ice_spike_projectile.tscn")

func activate_power():
	print("Power activated")
	var ice_spike = ICE_SPIKE_PROJECTILE.instantiate()
	main.add_child(ice_spike)
	ice_spike.position = position
	ice_spike.name = "IceSpike"
	return ice_spike

func _ready():
	sprite_2d.texture = sprite
	_ball_direction = ball_direction
	cpu_particles_2d.emitting = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_freezed:
		paddle_direction = Input.get_axis(control_up, control_down)
		if paddle_direction:
			position.y += velocity * paddle_direction * delta
			position.y = clamp(position.y, 60, y_size - 60)
		
		if Input.is_action_just_pressed("use_power") and is_ice_spike_touched:
			var spike = activate_power()
			spike.position.x -= 100
			is_ice_spike_touched = false
			power_used.emit()
		
	else:
		await get_tree().create_timer(1.5).timeout # waits for 1 second
		is_freezed = false
		cpu_particles_2d.emitting = false

func _on_ball_ice_spike_ball_touched(spike_ball):
	if is_ice_spike_touched_from_right:
		is_ice_spike_touched = true
		player_ice_spike_ready.emit(spike_ball)
	else:
		ai_ice_spike_ready.emit(spike_ball)


func _on_ball_bounced_from_right():
	print("ball bounced from right")
	is_ice_spike_touched_from_right = true


func _on_ball_bounced_from_left():
	print("ball bounced from left")
	is_ice_spike_touched_from_right = false


func _on_area_entered(area):
	if area.name.begins_with("IceSpike"):
		print("freeze")
		is_freezed = true
		cpu_particles_2d.emitting = true


func _on_ball_get_bigger_ball_touched(get_bigger_ball):
	if is_ice_spike_touched_from_right:
		print("GET BIGGER BALL TOUCHED FROM THE PLAYER")
		is_ice_spike_touched = true
		get_bigger_ball.queue_free()
		player_get_bigger.emit(get_bigger_ball)
		scale.x = 3
		scale.y = 3
		await get_tree().create_timer(3).timeout # waits for 1 second
		scale.x = 1
		scale.y = 1
	else:
		print("GET BIGGER BALL TOUCHED FROM THE AI")
		ai_get_bigger.emit(get_bigger_ball)
		get_bigger_ball.queue_free()



func _on_ball_get_smaller_ball_touched(get_smaller_ball):
	if is_ice_spike_touched_from_right:
		print("GET SMALLER BALL TOUCHED FROM THE PLAYER")
		is_ice_spike_touched = true
		get_smaller_ball.queue_free()
		player_get_smaller.emit(get_smaller_ball)
		player_left.scale.x = 0.5
		player_left.scale.y = 0.5
		await get_tree().create_timer(3).timeout # waits for 1 second
		player_left.scale.x = 1
		player_left.scale.y = 1
	else:
		print("GET BIGGER BALL TOUCHED FROM THE AI")
		ai_get_smaller.emit(get_smaller_ball)
		get_smaller_ball.queue_free()
