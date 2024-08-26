extends Control
class_name WIN

func _on_timer_timeout():
	Curtain.change_scene_to_file("res://UI/MainScreens/MenuScreen/MenuScreen.tscn")


func _ready():
	$Center/GameOver.text = "[center][wave] you win
score: %s [/wave][/center]" % Main.score
	Main.score = 0
