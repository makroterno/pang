extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D
var screen_size = Vector2()
@onready var timer = Timer.new()

func _ready():

	screen_size = get_viewport_rect().size
	await get_tree().create_timer(randf_range(2, 12)).timeout # waits for 1 second
	_randomize_position()

func _process(delta):
	pass
 
func _on_player_right_power_used():
	self.visible = false
	await get_tree().create_timer(randf_range(2, 12)).timeout # waits for 1 second
	_randomize_position()
	
func _randomize_position():
	self.visible = true
	animated_sprite_2d.play()
	position = Vector2(clamp(randf() * screen_size.x, 90, 1040), clamp(randf() * screen_size.y, 70, 615))
	
func _on_ball_ice_spike_ball_touched(spike_ball):
	position = Vector2(878, 27)
	animated_sprite_2d.stop()
