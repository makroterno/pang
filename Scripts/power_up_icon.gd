extends Area2D

@export var sprite : Texture2D

@onready var sprite_2d = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.texture = sprite
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
