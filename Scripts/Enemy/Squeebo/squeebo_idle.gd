class_name SqueeboIdle
extends EnemyState

@export var LOS:RayCast2D

func enter():
	anim_player.play("idle")

func physics_update(_delta):
	enemy.velocity = Vector2.ZERO
	if player_detection():
		transitioned.emit(self,"follow")

func _on_player_detected(_area):
	enemy.player_in_range = true
