class_name BlobShoot
extends EnemyState

@export var Attack_Timer:Timer
@export var attack_spawn:Node2D
@export var blob_attack_scene:PackedScene = preload("res://Scenes/Enemy/blob_attack.tscn")

var pushback:int = 1000

func enter():
	anim_player.play("attack")
	Attack_Timer.start()

func exit():
	Attack_Timer.stop()

func physics_update(_delta):
	enemy.velocity = Vector2.ZERO

func _on_attack_range_area_exited(_area):
	enemy.can_attack = false

func _on_attack_timer_timeout():
	shoot()
	if !enemy.can_attack:
		transitioned.emit(self,"follow")

func shoot():
	var projectile = blob_attack_scene.instantiate()
	projectile.initialize(enemy.global_position, enemy.player_direction.angle())
	get_parent().add_child(projectile)
	projectile.activate(attack_spawn)
	enemy.velocity -= enemy.player_direction.normalized() * pushback
