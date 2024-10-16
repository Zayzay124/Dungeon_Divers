extends EnemyState
class_name BlobIdle


func enter():
	print("sleeping")
	anim_player.play("idle")
	#play sleep animaiton


func physics_update(_delta):
	enemy.velocity = Vector2.ZERO

func _on_player_detected(area):
	transitioned.emit(self,"follow")
