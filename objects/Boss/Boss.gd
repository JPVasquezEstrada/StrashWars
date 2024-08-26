extends Area2D

class_name Boss

const REC_BULLET = preload("res://objects/damage_object/Bullet.tscn")

const GET_LIVES_PROB = 10

@export
var limit_left : int
@export
var limit_right : int

enum MovementType {
	RIGHT,
	LEFT
}

@export
var movement_type : MovementType

var speed := 20

var dir := Vector2.ZERO
var mov := Vector2.ZERO

var time := 0.0
var time_fire := 0.0

var fire := false

var bullet_owner := Main.BulletOwner.ENEMY
var rand_number
var health:= 10

func _ready():
	randomize()
	rand_number = randi_range(2, 3)

func _process(delta):
	match movement_type:
		MovementType.RIGHT:
			movement_right(delta)
		MovementType.LEFT:
			movement_left(delta)
	
	fire_bullets(delta)

func setup(_movement_type : MovementType):
	movement_type = _movement_type
	
	limit_left = global_position.x -30
	limit_right = global_position.x + 300
	
	match movement_type:
		MovementType.RIGHT:
			dir.x = 1
			dir.y= -1
		MovementType.LEFT:
			dir.x = -1
			dir.y= 1


func fire_bullets(delta):
	time_fire += delta
	
	if time_fire > rand_number:
		fire = true
	if fire:
		var bullet_spawns = [
			$BulletSpawn, 
			$BulletSpawn2, 
			$BulletSpawn3, 
			$BulletSpawn4, 
			$BulletSpawn5, 
			$BulletSpawn6
		]

		for spawn in bullet_spawns:
			var inst_bullet = REC_BULLET.instantiate()
			get_parent().add_child(inst_bullet)
			inst_bullet.direction = inst_bullet.BulletDirection.BOTTOM
			inst_bullet.global_position = spawn.global_position
			inst_bullet.bullet_owner = Main.BulletOwner.ENEMY
		
		rand_number = randf_range(
			clamp(1 - Main.level * 1.05, 0.5, 6.0), 
			clamp(1 - Main.level * 1.1, 2, 20)
		)
		
		time_fire = 0
		$EnemyLaser.play()
		fire = false
	
	#if fire:
		#var inst_bullet = REC_BULLET.instantiate()
		#get_parent().add_child(inst_bullet)
		#inst_bullet.direction = inst_bullet.BulletDirection.BOTTOM
		#inst_bullet.global_position = $BulletSpawn.global_position
		#inst_bullet.global_position = $BulletSpawn3.global_position
		#inst_bullet.global_position = $BulletSpawn4.global_position
		#inst_bullet.global_position = $BulletSpawn5.global_position
		#inst_bullet.global_position = $BulletSpawn6.global_position
		#inst_bullet.global_position = $BulletSpawn2.global_position
		#inst_bullet.bullet_owner = Main.BulletOwner.BOSS
		#
		#rand_number = randf_range(
			#clamp(1 - Main.level * 1.05, 0.5, 6.0), 
			#clamp(1 - Main.level * 1.1, 2, 20)
		#)
		#
		#time_fire = 0
		#$EnemyLaser.play()
		#fire = false


func movement_right(delta):
	time += delta
	
	if global_position.x < limit_right:
		mov.y = dir.x * delta * speed
		mov.x = sin(time * 2) * 1
	else:
		movement_type = MovementType.LEFT
	
	global_position += mov
func movement_left(delta):
	time -= delta
	
	if global_position.x > limit_left:
		mov.y = -(dir.x * delta * speed)
		mov.x = -(sin(time * 2) * 1)
	else:
		movement_type = MovementType.RIGHT
	
	global_position += mov
func movement_rightUp (delta):
	time += delta
	
	if global_position.x < limit_right:
		mov.x = dir.x * delta * speed
		mov.y = sin(time * 2) * 1
	else:
		movement_type = MovementType.LEFT
	
	global_position += mov
func movement_leftUp (delta):
	time -= delta
	
	if global_position.x > limit_left:
		mov.x = -(dir.x * delta * speed)
		mov.y = -(sin(time * 2) * 1)
	else:
		movement_type = MovementType.RIGHT
	
	global_position += mov

func _on_animation_boss_animation_finished(anim_name):
	if anim_name == "BossDestroi":
		health -= 5
		if health > 0:
			$CollisionShape2D.set_deferred("disabled", false)
			$EnemyHit.play()
		else:
			if (randi() % GET_LIVES_PROB + 1) == 1:
				Main.lives += 1
			Main.score += 250
			$EnemyDead.play()
			queue_free()
			Curtain.change_scene_to_file("res://UI/MainScreens/Win/Win.tscn")
			
		
func take_damage(damage):
	health -= damage
	if health <= 0:
		dead()

func dead():
		$AnimationBoss.play("BossDestroi")
#
#extends Area2D
#class_name Boss
#
#const REC_BULLET = preload("res://objects/damage_object/Bullet.tscn")
#const GET_LIVES_PROB = 10
#
#@export var limit_left : int
#@export var limit_right : int
#
#enum MovementType {
	#RIGHT,
	#LEFT,
	#RIGHT_UP,
	#LEFT_UP
#}
#
#@export var movement_type : MovementType
#var speed := 20
#var dir := Vector2.ZERO
#var mov := Vector2.ZERO
#var time := 0.0
#var time_fire := 0.0
#var fire := false
#var bullet_owner := Main.BulletOwner.ENEMY
#var rand_number
#var health := 100  # Aumentar la salud del boss
#
#func _ready():
	#randomize()
	#rand_number = randi_range(2, 3)
#
#func _process(delta):
	#match movement_type:
		#MovementType.RIGHT:
			#movement_right(delta)
		#MovementType.LEFT:
			#movement_left(delta)
		#MovementType.RIGHT_UP:
			#movement_rightUp(delta)
		#MovementType.LEFT_UP:
			#movement_leftUp(delta)
	#
	#fire_bullets(delta)
#
#func setup(_movement_type : MovementType):
	#movement_type = _movement_type
	#limit_left = global_position.x - 30
	#limit_right = global_position.x + 300
	#
	#match movement_type:
		#MovementType.RIGHT:
			#dir.x = 1
			#dir.y = -1
		#MovementType.LEFT:
			#dir.x = -1
			#dir.y = 1
		#MovementType.RIGHT_UP:
			#dir.x = 1
			#dir.y = 1
		#MovementType.LEFT_UP:
			#dir.x = -1
			#dir.y = -1
#
#func fire_bullets(delta):
	#time_fire += delta
	#
	#if time_fire > rand_number:
		#fire = true
	#
	#if fire:
		#var inst_bullet = REC_BULLET.instantiate()
		#get_parent().add_child(inst_bullet)
		#inst_bullet.direction = inst_bullet.BulletDirection.BOTTOM
		#inst_bullet.global_position = $BulletSpawn.global_position
		#inst_bullet.bullet_owner = Main.BulletOwner.ENEMY
		#
		#rand_number = randf_range(
			#clamp(3 - Main.level * 1.05, 0.5, 6.0), 
			#clamp(15 - Main.level * 1.1, 2, 20)
		#)
		#
		#time_fire = 0
		#$EnemyLaser.play()
		#fire = false
#
#func movement_right(delta):
	#time += delta
	#
	#if global_position.x < limit_right:
		#mov.y = dir.x * delta * speed
		#mov.x = sin(time * 2) * 1
	#else:
		#movement_type = MovementType.LEFT
	#
	#global_position += mov
#func movement_left(delta):
	#time -= delta
	#
	#if global_position.x > limit_left:
		#mov.y = -(dir.x * delta * speed)
		#mov.x = -(sin(time * 2) * 1)
	#else:
		#movement_type = MovementType.RIGHT
	#
	#global_position += mov
#func movement_rightUp (delta):
	#time += delta
	#
	#if global_position.x < limit_right:
		#mov.x = dir.x * delta * speed
		#mov.y = sin(time * 2) * 1
	#else:
		#movement_type = MovementType.LEFT
	#
	#global_position += mov
#func movement_leftUp (delta):
	#time -= delta
	#
	#if global_position.x > limit_left:
		#mov.x = -(dir.x * delta * speed)
		#mov.y = -(sin(time * 2) * 1)
	#else:
		#movement_type = MovementType.RIGHT
	#
	#global_position += mov
#
#func take_damage(damage):
	#health -= damage
	#if health <= 0:
		#dead()
#
#func dead():
	#$CollisionShape2D.set_deferred("disabled", true)
	#$AnimationBoss.play("destroy")
	#$EnemyDead.play()
#
#func _on_animdestroy_animation_finished(anim_name):
	#if anim_name == "destroy":
		#if (randi() % GET_LIVES_PROB + 1) == 1:
			#Main.lives += 1
		#Main.score += 5
		#queue_free()


