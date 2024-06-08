extends Node2D
class_name Player
var velocity : float = 100.0
@export var sprite : Texture2D
@export var direction : int = 1
@export var control_up : String = ""
@export var control_down : String = ""
var y_size = get_viewport_rect().size # May be buggy if there will be a size change since this only initalizes once

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction = Input.get_axis(control_down, control_up)
	if direction:
		position.y += velocity * direction
		
func _on_body_entered(body):
	body.direction = direction
