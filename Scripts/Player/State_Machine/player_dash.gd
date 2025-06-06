class_name Player_Dash
extends PlayerState

var dash_dir:Vector2 = Vector2.ZERO
var dash_speed:int = 300
var dashing:bool = false

@export var dash_duration:float = 0.2
@export var hurtbox:CollisionShape2D
@export var falldetector:CollisionShape2D
@export var Res_Point_Timer:Timer

@onready var Dash_Timer = $DashTimer
func enter():
	dashing = true
	hurtbox.disabled = true
	falldetector.disabled = true
	Dash_Timer.start(dash_duration)
	Res_Point_Timer.stop()
	anim_player.play("dash")
	dash()

func exit():
	dashing = false
	hurtbox.disabled = false
	falldetector.disabled = false
	Res_Point_Timer.start()

func physics_update(_delta):
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
