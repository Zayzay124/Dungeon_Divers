class_name Player_Idle
extends PlayerState

func enter():
	print("player idle")
	anim_player.play("idle")
	player.velocity = Vector2.ZERO


func physics_update(delta):
	if player.input_dir != Vector2.ZERO:
		transitioned.emit(self,"move")
