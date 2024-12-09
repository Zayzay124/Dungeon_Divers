class_name Player_Fall
extends PlayerState

@export var hurtbox:CollisionShape2D
@export var falldetector:CollisionShape2D

func enter():
	$FallTimer.start()
	hurtbox.disabled = true
	falldetector.disabled = true
	anim_player.play("fall")
	await get_tree().create_timer(1).timeout
	player.pitfall()


func physics_update(_delta):
	player.velocity = Vector2.ZERO

func exit():
	hurtbox.disabled = false
	falldetector.disabled = false
	player.fallen = false

func _on_fall_timer_timeout():
	transitioned.emit(self,"idle")
