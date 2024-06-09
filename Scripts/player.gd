extends Node2D
class_name Player
var velocity : float = 500.0
@export var sprite : Texture2D

@export var ball_direction = Vector2(1, 0)
var _ball_direction = Vector2(1, 0)
var paddle_direction : int = 1

@export var control_up : String = ""
@export var control_down : String = ""

@onready var y_size = get_viewport_rect().size.y # May be buggy if there will be a size change since this only initalizes once
@onready var sprite_2d = $Sprite2D



func _ready():
	sprite_2d.texture = sprite
	_ball_direction = ball_direction

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	paddle_direction = Input.get_axis(control_up, control_down)
	if paddle_direction:
		position.y += velocity * paddle_direction * delta
		position.y = clamp(position.y, 60, y_size - 60)
		
func _on_area_entered(area):
	if area.name == "Ball":
		var rng = RandomNumberGenerator.new()
		print("rng: ", rng)
		print("Ball entered the paddle")
		#TODO: Increase this code quality & improve ball behaviour
		area.direction = Vector2(_ball_direction.x, rng.randf_range(-1.0, 1.0))


