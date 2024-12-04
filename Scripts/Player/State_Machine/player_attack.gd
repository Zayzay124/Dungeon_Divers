class_name Player_Attack
extends PlayerState

@export var attack_origin:Node2D

var attacking:bool = false

func enter():
	weapon_attack()
	await get_tree().create_timer(.5).timeout
	transitioned.emit(self,"move")

func physics_update(_delta):
	player_movement()

func weapon_attack():
	match player.current_weapon:
		Weapon_Pickup.WEAPON.NONE:
			print("nothing")
		Weapon_Pickup.WEAPON.SWORD:
			player.sword.activate(attack_origin)
		Weapon_Pickup.WEAPON.AXE:
			player.axe.activate(attack_origin)
		Weapon_Pickup.WEAPON.SPEAR:
			player.spear.activate(attack_origin)
		Weapon_Pickup.WEAPON.BOW:
			ranged_attack()

func ranged_attack():
	var projectile = player.range_attack_scene.instantiate()
	projectile.initialize(attack_origin.global_position, player.last_dir.angle())
	get_parent().add_child(projectile)
	projectile.activate(attack_origin)
