extends VideoStreamPlayer

@onready var video_stream_player = $VideoStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	#video_stream_player.play()
	pass

func _process(delta):
	if Input.is_action_just_pressed("p"):
		if !video_stream_player.is_playing():
			video_stream_player.play()
	if Input.is_action_just_pressed("enter"):
		Curtain.change_scene_to_file("res://UI/MainScreens/MenuScreen/MenuScreen.tscn")
