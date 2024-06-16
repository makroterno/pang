extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D
var screen_size = Vector2()

func _on_ball_ice_spike_ball_touched(spike_ball):
	position = Vector2(878, 27)
	animated_sprite_2d.stop()
