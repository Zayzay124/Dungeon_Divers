extends EnemyState
class_name BlobShoot

signal attacking(player_pos)

func enter():
	print("shoot")
	await get_tree().create_timer(0.6).timeout
	player_direction = player.global_position - enemy.global_position
	attacking.emit(player_direction.normalized())

func physics_update(_delta):
	player_direction = player.global_position - enemy.global_position

func _on_attack_range_area_exited(area):
	transitioned.emit(self,"follow")
