extends Player
@onready var ball = $"../../Ball"
var vel : float = 400.0
var is_freezed : bool = false
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
		if not is_freezed:
			position.y += direction * vel * delta
		else:

			await get_tree().create_timer(1.5).timeout # waits for 1 second
			is_freezed = false
			cpu_particles_2d.emitting = false


func _on_area_entered(area):
	print("Left paddle area enter name: ", area.name)
	if area.name.begins_with("IceSpike"):
		print("freeze")
		is_freezed = true
		cpu_particles_2d.emitting = true
