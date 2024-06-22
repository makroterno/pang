extends Node2D
@onready var label = $Label

var countdown_value = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	countdown_value -= delta
	if countdown_value < 3 and countdown_value > 2:
		label.text = str(3)
	
	elif countdown_value < 2 and countdown_value > 1:
		label.text = str(2)
	
	elif countdown_value < 1 and countdown_value > 0:
		label.text = str(1)
	
	else:
		hide()
		get_tree().paused = false
		queue_free()
		
