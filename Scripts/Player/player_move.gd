class_name Player_Move
extends PlayerState

@export var speed:int = 300

func enter():
	print("player walk")
	anim_player.play("walk")


func physics_update(delta):
	player.velocity = player.input_dir * speed
	player.move_and_collide(player.velocity * delta)
	
	if player.input_dir == Vector2.ZERO:
		transitioned.emit(self,"idle")

#replace with match?
func _input(event):
	if event.is_action_pressed("dash"):
		transitioned.emit(self,"dash")
	if event.is_action_pressed("weapon_attack"):
		transitioned.emit(self,"attack")
