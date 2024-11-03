extends CharacterBody2D

##Signals
signal taken_damage # talks to HUD

@export var speed:int = 300
@export var health:int = 0
@export var magic_points:int = 50

var current_weapon:Weapon_Pickup.WEAPON

var input_dir:Vector2 = Vector2.ZERO
var last_dir:Vector2 = Vector2.RIGHT

var is_invincible:bool = false

var respawn_point:Vector2 = Vector2.ZERO

##PreLoad Scenes
@export var range_attack_scene:PackedScene = preload("res://Scenes/arrow.tscn")
@export var melee_attack_scene:PackedScene = preload("res://Scenes/sword.tscn")

##Nodes vars to instantiate attack scenes in
var melee:Node

func _ready():
	melee = melee_attack_scene.instantiate()
	add_child(melee)

func _process(_delta):
	orient()

func _physics_process(delta):
	input_dir = Input.get_vector("left","right","up","down");
	
	if input_dir != Vector2.ZERO:
		last_dir = input_dir
	
	input_dir = input_dir.normalized()
	move_and_collide(velocity * delta)

func _input(event):
	if event.is_action_pressed("interact"):
		for area in $HurtBox.get_overlapping_areas(): #might run into problem where two weapons are on top of each other
			if area.is_in_group("Weapon_Pickup"):
				var old_weapon = current_weapon
				current_weapon = area.weapon_type
				area.picked_up(old_weapon)
	if event.is_action_pressed("description"):
		for area in $HurtBox.get_overlapping_areas():
			area.change_desc_visibility()

func hit(amount):
	print("taken_damage")
	health -= amount
	taken_damage.emit()
	if health <= 0:
		pitfall()

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
