extends Node2D


const REC_PLAYER = preload("res://Game/Players/Player.tscn")
const REC_ENEMY = preload("res://objects/Enemy/Enemy.tscn")

const INITAL_POS = Vector2(384, 417)

var Meteoro= preload("res://objects/Meteorite/Meteorite.tscn")


func _ready():
	#spawn_enemies()
	spawn_player()
	Main.lives = 1
	Signals.dead.connect(_on_dead)
	$LevelMusic.play()


func _input(event):
	# Para testeo de la vidas
	if event.is_action_pressed("1"):
		Main.lives += 1
	elif event.is_action_pressed("2"):
		Main.lives -= 1


func spawn_player():
	var new_player = REC_PLAYER.instantiate()
	add_child(new_player)
	new_player.global_position = INITAL_POS


#func spawn_enemies():
	#var x_increment := +80
	#var y_increment := -30
	#
	#for i in 1:
		#y_increment += 50
		#
		#for j in 6:
			#var enemy = REC_ENEMY.instantiate()
			#$Enemies.add_child(enemy)
			#
			#enemy.global_position.x = x_increment
			#enemy.global_position.y = y_increment
			#enemy.setup(enemy.MovementType.RIGHT)
			#
			#x_increment += 60
		#
		#x_increment = 138


func _on_dead():
	spawn_player()


func _on_timer_timeout():
	if $Enemies.get_child_count() == 0:
		Main.level += 1
		#spawn_enemies()


func _on_meteor_timer_timeout():
	var path_follow = $Player/Camera/Path2D/PathFollow2D
	if path_follow:
		var aleatorio = randf()  # Genera un valor aleatorio entre 0 y 1
		path_follow.progress_ratio = aleatorio
		var meteoro = Meteoro.instantiate()  # Cambiado a instantiate() para Godot 4
		meteoro.position = path_follow.global_position
		get_parent().add_child(meteoro)
	else:
		print("Error: PathFollow2D no encontrado")
