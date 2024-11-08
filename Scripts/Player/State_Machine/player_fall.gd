class_name Player_Fall
extends PlayerState

func enter():
	anim_player.play("fall")
	player.velocity = Vector2.ZERO
	#await get_tree().create_timer(0.5).timeout
	transitioned.emit(self,"idle")


func physics_update(_delta):
	pass
