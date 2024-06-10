extends Player
@onready var ball = $"../../Ball"
var vel : float = 400.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ball:
		# Calculate the direction to move (towards the ball's y position)
		var direction = 0
		if ball.position.x <= 576:
			if ball.position.y > position.y:
				direction = 1
			elif ball.position.y < position.y:
				direction = -1
		
		# Move the paddle
		position.y += direction * vel * delta

