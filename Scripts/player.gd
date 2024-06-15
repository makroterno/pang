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
		# Determine the position where the ball hits the paddle
		var paddle_center_y = position.y
		var impact_y = area.position.y - paddle_center_y

		# Normalize the impact point (-1.0 to 1.0 range)
		var paddle_height = sprite_2d.texture.get_size().y
		var impact_factor = (impact_y / (paddle_height / 2))

		# Modify ball's direction based on impact factor
		var ball_direction = area.direction
		ball_direction.y = impact_factor
		ball_direction = ball_direction.normalized()

		# Optionally adjust speed based on paddle's velocity (if paddle is moving)
		var paddle_velocity = Vector2(0, 0) # Replace with your paddle's actual velocity if available
		var ball_speed = area.speed
		ball_speed += paddle_velocity.length() * 0.1 # Adjust the factor as needed

		# Set the new direction and speed to the ball
		area.direction = -ball_direction
		area.speed = ball_speed



