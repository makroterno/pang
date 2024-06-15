extends Area2D
signal hand_over

var speed = 200
var direction = Vector2(1, 1)

var _player_left_score = 0
var _player_right_score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if speed < 800:
		speed += 1
	position += direction * speed * delta
	
# Add top, bottom and wall collisions

func _on_area_entered(area):
	if area.name == "Top" or area.name == "Bottom":
		direction.y = -direction.y
	
	elif area.name == "Left" or area.name == "Right":
		emit_signal("hand_over", area)
		print("Ball reached the other side")

		position = Vector2(576, 324)
		speed = 200
