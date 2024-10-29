extends EnemyState
class_name SqueeboIdle


func enter():
	print("sleeping")
	anim_player.play("idle")

func physics_update(_delta):
	enemy.velocity = Vector2.ZERO

func _on_player_detected(_area):
	transitioned.emit(self,"follow")
