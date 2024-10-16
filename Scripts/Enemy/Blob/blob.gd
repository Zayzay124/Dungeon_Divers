extends CharacterBody2D

const speed:int = 75

@export var blob_attack_scene:PackedScene = preload("res://Scenes/blob_attack.tscn")

func _physics_process(delta):
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
	
	move_and_slide()

func _on_shoot(player_pos):
	var projectile = blob_attack_scene.instantiate()
	projectile.initialize(global_position, player_pos.angle())
	get_parent().add_child(projectile)
	projectile.activate($AttackSpawn)

func hit(amount):
	queue_free()
