extends Area2D

class_name Bullet

@export var speed := 200

enum BulletDirection {
	TOP,
	BOTTOM
}

@export 
var direction : BulletDirection

var bullet_owner := Main.BulletOwner.PLAYER


func _process(delta):
	match direction:
		BulletDirection.BOTTOM:
			global_position.y += delta * speed
		BulletDirection.TOP:
			global_position.y -= delta * speed


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is Enemy and bullet_owner == Main.BulletOwner.PLAYER:
		area.dead() # Enemy
		dead()
	if area is Boss and bullet_owner == Main.BulletOwner.PLAYER:
		area.dead() # Boss
		dead()
	elif area is Player and bullet_owner == Main.BulletOwner.ENEMY:
		area.dead() # Player
		dead()


func dead():
	$AnimationPlayer.play("destroy")
	$CollisionShape2D.call_deferred("set_disabled", true)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "destroy":
		queue_free()
