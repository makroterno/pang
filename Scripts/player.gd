extends Node2D
class_name Player
signal power_used

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
var is_ice_spike_available = false

const ICE_SPIKE_PROJECTILE = preload("res://Scenes/ice_spike_projectile.tscn")

func activate_power():
	print("Power activated")
	var ice_spike = ICE_SPIKE_PROJECTILE.instantiate()
	main.add_child(ice_spike)
	ice_spike.position = position
	ice_spike.name = "IceSpike"

func _ready():
	sprite_2d.texture = sprite
	_ball_direction = ball_direction
	cpu_particles_2d.emitting = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	paddle_direction = Input.get_axis(control_up, control_down)
	if paddle_direction:
		position.y += velocity * paddle_direction * delta
		position.y = clamp(position.y, 60, y_size - 60)
	
	if Input.is_action_just_pressed("use_power") and is_ice_spike_available:
		var spike = activate_power()
		is_ice_spike_available = false
		power_used.emit()

func _on_ball_ice_spike_ball_touched(spike_ball):
		is_ice_spike_available = true
