class_name BlobShoot
extends EnemyState

@export var Attack_Timer:Timer
@export var attack_spawn:Node2D
@export var blob_attack_scene:PackedScene = preload("res://Scenes/blob_attack.tscn")

func enter():
	print("shoot")
	anim_player.play("attack")
	Attack_Timer.start()

func exit():
	Attack_Timer.stop()

func physics_update(_delta):
	player_direction = player.global_position - enemy.global_position
	
	enemy.velocity = Vector2.ZERO

func _on_attack_range_area_exited(_area):
	transitioned.emit(self,"follow")

func _on_attack_timer_timeout():
	shoot()

func shoot():
	var projectile = blob_attack_scene.instantiate()
	projectile.initialize(enemy.global_position, player_direction.angle())
	get_parent().add_child(projectile)
	projectile.activate(attack_spawn)
	enemy.velocity -= player_direction.normalized() * enemy.pushback
