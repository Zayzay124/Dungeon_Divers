extends EnemyState
class_name BlobIdle


func enter():
	print("sleeping")
	#play sleep animaiton
	#anim_player.play("")

func physics_update(_delta):
	if enemy:
		enemy.velocity = Vector2.ZERO

func _on_player_detected(area):
	transitioned.emit(self,"follow")
