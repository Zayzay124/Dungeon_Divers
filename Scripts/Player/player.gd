extends CharacterBody2D

##Signals
signal taken_damage # talks to HUD

@export var speed:int
@export var health:int

var current_weapon:Weapon_Pickup.WEAPON

var input_dir:Vector2 = Vector2.ZERO
var last_dir:Vector2 = Vector2.RIGHT

var respawn_point:Vector2 = Vector2.ZERO
var fallen:bool = false

##Preload Weapon Scenes
@export var sword_scene:PackedScene = preload("res://Scenes/Weapons/sword.tscn")
@export var spear_scene:PackedScene = preload("res://Scenes/Weapons/spear.tscn")
@export var axe_scene:PackedScene = preload("res://Scenes/Weapons/axe.tscn")
@export var wand_scene:PackedScene = preload("res://Scenes/Weapons/wand.tscn")
@export var wand_attack_scene:PackedScene = preload("res://Scenes/wand_attack.tscn")

##Nodes vars to instantiate attack scenes in
var sword:Node
var spear:Node
var axe:Node
var wand:Node

func _ready():
	sword = sword_scene.instantiate()
	add_child(sword)
	spear = spear_scene.instantiate()
	add_child(spear)
	axe = axe_scene.instantiate()
	add_child(axe)
	wand = wand_scene.instantiate()
	add_child(wand)


func _process(_delta):
	orient()

func _physics_process(_delta):
	input_dir = Input.get_vector("left","right","up","down");
	
	if input_dir != Vector2.ZERO:
		last_dir = input_dir
	
	input_dir = input_dir.normalized()
	move_and_slide()

func _input(event):
	if event.is_action_pressed("interact"):
		for area in $HurtBox.get_overlapping_areas():
			if area.is_in_group("Weapon_Pickup"):
				var old_weapon = current_weapon
				current_weapon = area.weapon_type
				area.picked_up(old_weapon)
				print(current_weapon)
	if event.is_action_pressed("description"):
		for area in $HurtBox.get_overlapping_areas():
			area.change_desc_visibility()
	if event.is_action_pressed("ui_cancel"):
		pitfall()

func hit(amount):
	health -= amount
	print(health)
	taken_damage.emit(amount)
	$AnimationPlayer.play("hurt")
	await get_tree().create_timer(.5).timeout
	$AnimationPlayer.play("idle")
	if health <= 0:
		die()

func die():
	get_tree().change_scene_to_file("res://Scenes/Levels/main_menu.tscn")

func pitfall():
	position = respawn_point
	health -= 4

func orient():
	$AttackOrigin.position = 16 * last_dir
	$AttackOrigin.rotation = last_dir.angle()
	
	if last_dir.x < 0:
		$Sprite2D.scale.x = -1 #Flip left
	elif last_dir.x > 0:
		$Sprite2D.scale.x = 1 #Flip right

func _on_res_point_timer_timeout():
	respawn_point = position

func _on_fall_detector_body_entered(_body):
	fallen = true
	$FallDetector/CollisionShape2D.disabled = true
	$ResPointTimer.stop()
	await get_tree().create_timer(1).timeout
	$FallDetector/CollisionShape2D.disabled = false
	$ResPointTimer.start()
