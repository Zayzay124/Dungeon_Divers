class_name Player_Move
extends PlayerState

func enter():
	anim_player.play("walk")

func update(_delta):
	if fall_check(): transitioned.emit(self,"fall")

func physics_update(delta):
	player_movement()

	if player.input_dir == Vector2.ZERO:
		transitioned.emit(self,"idle")


func _input(event):
	if event.is_action_pressed("dash"):
		transitioned.emit(self,"dash")
	if event.is_action_pressed("weapon_attack"):
		transitioned.emit(self,"attack")
