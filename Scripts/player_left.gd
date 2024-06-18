extends Player

@onready var ball = $"../../Ball"
@onready var player_right = $"../PlayerRight"

const PLAYER_LEFT_ICED = preload("res://Assets/arts/Player-1.png_3-1.png.png")

var vel : float = 550.0
var is_freezed_left : bool = false

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
		if not is_freezed_left:
			position.y += direction * vel * delta
			position.y = clamp(position.y, 60, y_size - 60)
			
		else:
			sprite_2d.texture = PLAYER_LEFT_ICED
			await get_tree().create_timer(1.5).timeout # waits for 1 second
			sprite_2d.texture = sprite
			is_freezed_left = false

func _on_area_entered(area):
	if area.name.begins_with("IceSpike"):
		is_freezed_left = true
		#cpu_particles_2d.emitting = true

func _on_power_up_manager_get_bigger_available_left():
		scale.x = 3
		scale.y = 3
		await get_tree().create_timer(3).timeout # waits for 1 second
		scale.x = 1
		scale.y = 1



func _on_power_up_manager_get_smaller_available_left():
		player_right.scale.x = 0.5
		player_right.scale.y = 0.5
		await get_tree().create_timer(3).timeout # waits for 1 second
		player_right.scale.x = 1
		player_right.scale.y = 1


func _on_power_up_manager_ice_spike_available_left():
	await get_tree().create_timer(1).timeout # waits for 1 second
	var spike = activate_power()
	ai_ice_spike_touched = false
	power_used.emit()
	spike.direction = 1
	spike.position.x += 100
