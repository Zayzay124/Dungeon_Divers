extends EnemyState
class_name SqueeboFollow

func enter():
	print("squeebo_follow")
	anim_player.play("walk")

func physics_update(_delta):
	pass
	#player_direction = player.global_position - enemy.global_position
	
	#enemy.velocity = player_direction.normalized() * enemy.speed

func _on_attack_range_area_entered(_area):
	transitioned.emit(self,"attack")


func _on_player_detector_area_exited(_area):
	transitioned.emit(self,"idle")
