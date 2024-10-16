extends CharacterBody2D

##Signals
signal taken_damage # talks to HUD

@export var speed:int = 300
@export var health:int = 0
@export var magic_points:int = 50
@export var dash_speed:int = 10

var current_weapon:Weapon_Pickup.WEAPON

var input_dir:Vector2 = Vector2.ZERO
var last_dir:Vector2 = Vector2.ZERO

var dash_dir:Vector2 = Vector2.ZERO

var is_invincible:bool = false


##PreLoad Scenes
@export var range_attack_scene:PackedScene = preload("res://Scenes/arrow.tscn")
@export var melee_attack_scene:PackedScene = preload("res://Scenes/sword.tscn")

##Nodes vars to instantiate attack scenes in
var melee:Node

func _ready():
	melee = melee_attack_scene.instantiate()
	add_child(melee)

func _process(delta):
	orient()

func _physics_process(delta):
	input_dir = Input.get_vector("left","right","up","down");
	
	if input_dir != Vector2.ZERO:
		last_dir = input_dir
	
	input_dir = input_dir.normalized()

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

func orient():
	##TODO get rid of magic number 16
	#16 is from center of player to edge of player 
	$AttackOrigin.position = 16 * last_dir
	$AttackOrigin.rotation = last_dir.angle()
