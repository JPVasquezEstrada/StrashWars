extends Area2D
var speed = 50
var life

# Called when the node enters the scene tree for the first time.
func _ready():
	var scal = randf_range(0.3,0.7)
	scale= Vector2(scal,scal)
	if scal >= 0.7:
		life=3
		speed= 50
	if scal < 0.5:
		life=2
		speed= 100
	if scal  < 0.4:
		life=1
		speed= 150

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2(0,speed*delta)

