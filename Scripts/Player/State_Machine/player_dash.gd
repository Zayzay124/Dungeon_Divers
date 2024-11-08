class_name Player_Dash
extends PlayerState

var dash_dir:Vector2 = Vector2.ZERO
var dash_speed:int = 300
var dashing:bool = false

@export var dash_duration:float = 0.2
@onready var Dash_Timer = $DashTimer

func enter():
	dashing = true
	Dash_Timer.start(dash_duration)
	anim_player.play("dash")
	dash()

func exit():
	dashing = false

func physics_update(delta):
	if !dashing:
		transitioned.emit(self,"idle")

func dash():
	if player.input_dir != Vector2.ZERO:
		dash_dir = player.input_dir
	else:
		dash_dir = player.last_dir
	player.velocity = dash_dir.normalized() * dash_speed

func _on_dash_timer_timeout():
	dashing = false
