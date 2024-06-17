extends Player

@onready var ball = $"../../Ball"

var vel : float = 550.0
var is_freezed2 : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if ball:
		# Calculate the direction to move (towards the ball's y position)
		var direction = 0
		if ball.position.x <= 1000:
			if ball.position.y > position.y:
				direction = 1
			elif ball.position.y < position.y:
				direction = -1
		
		# Move the paddle
		if not is_freezed2:
			position.y += direction * vel * delta
			position.y = clamp(position.y, 60, y_size - 60)
			
		else:
			await get_tree().create_timer(1.5).timeout # waits for 1 second
			is_freezed2 = false
			cpu_particles_2d.emitting = false


func _on_area_entered(area):
	print("Left paddle area enter name: ", area.name)
	if area.name.begins_with("IceSpike"):
		print("freeze")
		is_freezed2 = true
		cpu_particles_2d.emitting = true


func _on_player_right_ai_ice_spike_ready(spike_ball):
	print("I ACQUIRED THE ICE SPIKE")
	await get_tree().create_timer(1).timeout # waits for 1 second
	var spike = activate_power()
	ai_ice_spike_touched = false
	power_used.emit()
	spike.direction = 1
	spike.position.x += 100
