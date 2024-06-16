extends Area2D
signal hand_over
signal ice_spike_ball_touched

var speed = 200
var direction = Vector2(1, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if speed < 800:
		speed += 1
	else:
		speed = 800
	position += direction * speed * delta
	
# Add top, bottom and wall collisions

func _handle_paddle_collision(paddle):
	# Determine the position where the ball hits the paddle
	var paddle_center_y = paddle.position.y
	var impact_y = position.y - paddle_center_y

	# Normalize the impact point (-1.0 to 1.0 range)
	var paddle_height = paddle.sprite_2d.texture.get_size().y
	var impact_factor = (impact_y / (paddle_height / 2))

	# Modify ball's direction based on impact factor
	paddle.ball_direction.y = impact_factor
	paddle.ball_direction = paddle.ball_direction.normalized()

	# Optionally adjust speed based on paddle's velocity (if paddle is moving)
	var paddle_velocity = Vector2(0, paddle.velocity) # Replace with your paddle's actual velocity if available
	var ball_speed = speed
	ball_speed += paddle_velocity.length() * 0.1 # Adjust the factor as needed
	direction = paddle.ball_direction


func _on_area_entered(area):
	if area.name == "Top" or area.name == "Bottom":
		direction.y = -direction.y
	
	elif area.name == "Left" or area.name == "Right":
		emit_signal("hand_over", area)

	elif area.name == "PlayerLeft" or area.name == "PlayerRight":
		_handle_paddle_collision(area)
		
	elif area.name.begins_with("IceSpikeBall"):
		emit_signal("ice_spike_ball_touched", area)


