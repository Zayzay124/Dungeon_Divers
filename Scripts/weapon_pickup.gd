class_name Weapon_Pickup
extends Node

enum WEAPON {SWORD,BOW}

@export var weapon_type:WEAPON

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	$PickupOption.visible = true

func _on_body_exited(body):
	$PickupOption.visible = false
