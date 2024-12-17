class_name SqueeboAttack
extends EnemyState

@export var Attack_Timer:Timer
@export var attack_origin:Node2D

var attack_dir:float

func enter():
	anim_player.play("idle")
	Attack_Timer.start()

func exit():
	Attack_Timer.stop()

func physics_update(_delta):
	enemy.velocity = Vector2.ZERO

func orient(): #this is like the worst code ever but it's 3 AM and i need this to work for the playtest
	attack_dir = rad_to_deg(enemy.player_direction.angle())
	if attack_dir >-45 and attack_dir < 45: #right
		attack_origin.position.x = 16
		attack_origin.position.y = 0
		attack_origin.rotation = deg_to_rad(0)
	elif attack_dir > 135 or attack_dir < -135: #left
		attack_origin.position.x = -16
		attack_origin.position.y = 0
		attack_origin.rotation = deg_to_rad(180)
	elif attack_dir >-135 and attack_dir < -45: #up
		attack_origin.position.x = 0
		attack_origin.position.y = -16
		attack_origin.rotation = deg_to_rad(-90)
	elif attack_dir > 45 and attack_dir < 135: #down
		attack_origin.position.x = 0
		attack_origin.position.y = 16
		attack_origin.rotation = deg_to_rad(90)

func _on_attack_range_area_exited(_area):
	enemy.can_attack = false

func _on_attack_timer_timeout():
	orient()
	enemy.sword.activate(attack_origin)
	if !enemy.can_attack:
		transitioned.emit(self,"follow")
