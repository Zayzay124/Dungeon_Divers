extends CharacterBody2D

const speed:int = 75

var pushback:int = 1000

#@export var blob_attack_scene:PackedScene = preload("res://Scenes/blob_attack.tscn")

func _physics_process(_delta):
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
	
	move_and_slide()

func hit(_amount):
	queue_free()
