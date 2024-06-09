extends Area2D

var X_SPEED : float = 100.0
var Y_SPEED : float = 100.0
var velocity_vector = Vector2(X_SPEED, Y_SPEED)
var direction = Vector2(1, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2(velocity_vector.x * direction.x , velocity_vector.y * direction.y) * delta
	
# Add top, bottom and wall collisions

func _on_area_entered(area):
	if area.name == "Top" or area.name == "Bottom":
		direction.y = -direction.y
	
	elif area.name == "Left" or area.name == "Right":
		get_tree().reload_current_scene()
