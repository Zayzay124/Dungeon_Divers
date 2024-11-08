class_name Weapon_Pickup
extends Node

enum WEAPON {NONE,SWORD,BOW}

@export var weapon_type:WEAPON

func _ready():
	$AnimatedSprite2D.frame = weapon_type

func _process(_delta):
	pass

func picked_up(weapon:WEAPON):
	if weapon == WEAPON.NONE:
		queue_free()
	self.weapon_type = weapon
	$AnimatedSprite2D.frame = weapon_type

func change_desc_visibility():
	$Options/Description.visible = !$Options/Description.visible

func _on_body_entered(_body):
	$Options.visible = true

func _on_body_exited(_body):
	$Options.visible = false
	$Options/Description.visible = false
