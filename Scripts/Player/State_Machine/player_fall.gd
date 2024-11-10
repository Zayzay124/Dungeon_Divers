class_name Player_Fall
extends PlayerState

var  falling:bool = false

func enter():
	pass
	#anim_player.play("fall")
	#await get_tree().create_timer(0.5).timeout


func physics_update(_delta):
	player.velocity = Vector2.ZERO

#lock player controls until animation is done playing
