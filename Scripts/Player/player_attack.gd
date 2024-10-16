class_name Player_Attack
extends PlayerState


@export var attack_origin:Node2D

func enter():
	print("player attack")
	weapon_attack()
	transitioned.emit(self,"idle")


func weapon_attack():
	match player.current_weapon:
		Weapon_Pickup.WEAPON.SWORD:
			melee_attack()
		Weapon_Pickup.WEAPON.BOW:
			ranged_attack()

func melee_attack():
	player.melee.activate(attack_origin)

func ranged_attack():
	var projectile = player.range_attack_scene.instantiate()
	projectile.initialize(attack_origin.global_position, player.last_dir.angle())
	get_parent().add_child(projectile)
	projectile.activate(attack_origin)
