class_name Weapon_Pickup
extends Node

enum WEAPON {SWORD,BOW}

@export var weapon_type:WEAPON

func _ready():
	print(weapon_type)
	$AnimatedSprite2D.frame = weapon_type

func _process(delta):
	pass

func picked_up(weapon:WEAPON):
	self.weapon_type = weapon
	$AnimatedSprite2D.frame = weapon_type

func _on_body_entered(body):
	$Options.visible = true

func _on_body_exited(body):
	$Options.visible = false
