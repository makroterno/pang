extends Area2D

var X_SPEED : float = 100.0
var Y_SPEED : float = 0.0
var velocity_vector = Vector2(X_SPEED, Y_SPEED)
var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity_vector * direction * delta
