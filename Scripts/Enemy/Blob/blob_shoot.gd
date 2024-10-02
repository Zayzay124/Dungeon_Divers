extends EnemyState
class_name BlobShoot

@export var Attack_Timer:Timer

signal attacking(player_pos)

func enter():
	print("shoot")
	Attack_Timer.start()

func exit():
	Attack_Timer.stop()

func physics_update(_delta):
	player_direction = player.global_position - enemy.global_position
	
	enemy.velocity = Vector2.ZERO

func _on_attack_range_area_exited(area):
	transitioned.emit(self,"follow")

func _on_attack_timer_timeout():
	attacking.emit(player_direction.normalized())
