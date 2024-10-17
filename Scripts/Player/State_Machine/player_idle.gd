class_name Player_Idle
extends PlayerState

func enter():
	print("player idle")
	anim_player.play("idle")
	player.velocity = Vector2.ZERO


func physics_update(_delta):
	if player.input_dir != Vector2.ZERO:
		transitioned.emit(self,"move")

func _input(event):
	if event.is_action_pressed("dash"):
		transitioned.emit(self,"dash")
	if event.is_action_pressed("weapon_attack"):
		transitioned.emit(self,"attack")
