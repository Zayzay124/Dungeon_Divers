extends EnemyState
class_name BlobFollow

func enter():
	print("follow")
	anim_player.play("walk")

func physics_update(_delta):
	player_direction = player.global_position - enemy.global_position
	
	enemy.velocity = player_direction.normalized() * enemy.speed

func _on_attack_range_area_entered(area):
	transitioned.emit(self,"shoot")


func _on_player_detector_area_exited(area):
	transitioned.emit(self,"idle")
