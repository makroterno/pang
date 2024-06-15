extends Area2D

var velocity = 800
var direction = -1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += direction * velocity * delta
	if position.x < 0 or position.x >= 1200:
		queue_free()
