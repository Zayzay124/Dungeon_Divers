class_name SqueeboFollow
extends EnemyState

func enter():
	anim_player.play("walk")

func physics_update(_delta):
	enemy.velocity = enemy.player_direction.normalized() * enemy.speed
	if !player_detection():
		transitioned.emit(self,"idle")
	elif player_detection() and enemy.can_attack:
		transitioned.emit(self,"attack")

func _on_attack_range_area_entered(_area):
	enemy.can_attack = true

func _on_player_detector_area_exited(_area):
	enemy.player_in_range = false
