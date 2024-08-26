extends Area2D
class_name Player
const REC_BULLET = preload("res://objects/damage_object/Bullet.tscn")
const REC_BULLET_BOSS = preload("res://objects/damage_object/BulletBoss.tscn")

const LIMIT_LEFT = 20
const LIMIT_RIGHT= 780

var speed:=300
var dir:=0
var my_velocity = Vector2.ZERO
var fire = false
var time = 0.0
var one_time_dead := true
var bullet_owner = Main.BulletOwner.PLAYER

func _process(delta):
	_physics_process(delta)
	fire_bullets(delta)

func _physics_process(delta):
	my_velocity = Vector2.ZERO

	if Input.is_action_pressed("d"):
		my_velocity.x = 100
	elif Input.is_action_pressed("a"):
		my_velocity.x = -100

	if Input.is_action_pressed("w"):
		my_velocity.y = -100
	elif Input.is_action_pressed("s"):
		my_velocity.y = 100

	if my_velocity.length() > 100:
		my_velocity = my_velocity.normalized() * 100

	position += my_velocity * delta
	position.x= clamp(position.x,LIMIT_LEFT,LIMIT_RIGHT)

	my_velocity.x = lerp(my_velocity.x, 0.0, 0.1)
	my_velocity.y = lerp(my_velocity.y, 0.0, 0.1)

func fire_bullets(delta):
	time += delta
	fire = Input.is_action_just_pressed("f")

	if fire and time >= 0.2:
		var inst_bullet
		if fire and time >= 0.2:
			inst_bullet = REC_BULLET_BOSS.instantiate()
		else:
			inst_bullet = REC_BULLET.instantiate()
		get_parent().add_child(inst_bullet)
		inst_bullet.direction = inst_bullet.BulletDirection.TOP
		inst_bullet.global_position = $BulletSpawn.global_position
		$Laser.play()
		time = 0.0
		
		
func dead():
	if not $AnimationPlayer.is_playing() and one_time_dead:
		$AnimationPlayer.play("dead")
		one_time_dead = false
		
		Main.lives -= 1
		$Explosion.play()
		Main.lives <= -1
	#if not $AnimationPlayer.is_playing() and one_time_dead:
		#$AnimationPlayer.play("dead")
		#one_time_dead = false
		#
		#Main.lives -= 1
		#$Explosion.play()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "dead":
		queue_free()
