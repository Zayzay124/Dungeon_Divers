class_name Player_Fall
extends PlayerState

var  falling:bool = false

func enter():
	print("fallen state")
	$FallTimer.start()
	player.pitfall()
	anim_player.play("fall")


func physics_update(_delta):
	player.velocity = Vector2.ZERO

func exit():
	player.fallen = false

func _on_fall_timer_timeout():
	transitioned.emit(self,"idle")
