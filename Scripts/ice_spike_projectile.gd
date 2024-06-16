extends Area2D

var velocity = 800
var direction = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += direction * velocity * delta
	if position.x < 0 or position.x >= 1200:
		queue_free()
