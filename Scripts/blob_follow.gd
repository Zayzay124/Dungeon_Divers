extends EnemyState
class_name BlobFollow

func enter():
	print("follow")
	await get_tree().create_timer(0.6).timeout

func physics_update(_delta):
	player_direction = player.global_position - enemy.global_position
	
	enemy.velocity = player_direction.normalized() * player.speed

func _on_attack_range_area_entered(area):
	transitioned.emit(self,"shoot")


func _on_player_detector_area_exited(area):
	transitioned.emit(self,"idle")
