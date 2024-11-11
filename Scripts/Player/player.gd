extends CharacterBody2D

##Signals
signal taken_damage # talks to HUD

@export var speed:int = 300
@export var health:int = 0
@export var magic_points:int = 50

var current_weapon:Weapon_Pickup.WEAPON

var input_dir:Vector2 = Vector2.ZERO
var last_dir:Vector2 = Vector2.RIGHT

var respawn_point:Vector2 = Vector2.ZERO
var has_fallen:bool = false

##PreLoad Scenes
@export var range_attack_scene:PackedScene = preload("res://Scenes/arrow.tscn")
@export var melee_attack_scene:PackedScene = preload("res://Scenes/sword.tscn")

##Nodes vars to instantiate attack scenes in
var melee:Node

func _ready():
	print(current_weapon)
	melee = melee_attack_scene.instantiate()
	add_child(melee)

func _process(_delta):
	orient()

func _physics_process(delta):
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
	print("taken_damage")
	health -= amount
	taken_damage.emit()
	if health <= 0:
		die()

func die():
	#load death screen
	pass

func pitfall():
	position = respawn_point

func orient():
	$AttackOrigin.position = 16 * last_dir
	$AttackOrigin.rotation = last_dir.angle()
	
	if last_dir.x < 0:
		$Sprite2D.scale.x = -1 #Flip left
	elif last_dir.x > 0:
		$Sprite2D.scale.x = 1 #Flip right

func _on_res_point_timer_timeout():
	respawn_point = position

func _on_fall_detector_body_entered(body):
	print("fall")
	velocity = Vector2.ZERO
	$FallDetector/CollisionShape2D.disabled = true
	$ResPointTimer.stop()
	await get_tree().create_timer(1).timeout
	pitfall()
	$FallDetector/CollisionShape2D.disabled = false
	$ResPointTimer.start()
