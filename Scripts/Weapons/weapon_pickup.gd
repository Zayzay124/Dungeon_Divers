class_name Weapon_Pickup
extends Node

enum WEAPON {NONE,SWORD,SPEAR,AXE,BOW}

@export var weapon_type:WEAPON

func _ready():
	init_anim()

func _process(_delta):
	pass

func picked_up(weapon:WEAPON):
	self.weapon_type = weapon
	init_anim()

func change_desc_visibility():
	$Options/Description.visible = !$Options/Description.visible

func _on_body_entered(_body):
	$Options.visible = true

func _on_body_exited(_body):
	$Options.visible = false
	$Options/Description.visible = false

func init_anim():
	match self.weapon_type:
		Weapon_Pickup.WEAPON.NONE:
			queue_free()
		Weapon_Pickup.WEAPON.SWORD:
			$AnimatedSprite2D.play("sword_idle")
		Weapon_Pickup.WEAPON.SPEAR:
			$AnimatedSprite2D.play("spear_idle")
		Weapon_Pickup.WEAPON.AXE:
			$AnimatedSprite2D.play("axe_idle")
