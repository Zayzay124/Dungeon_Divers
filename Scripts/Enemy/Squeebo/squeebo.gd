class_name Squeebo
extends Enemy

var sword:Node

func _ready():
	sword = attack_scene.instantiate()
	add_child(sword)
