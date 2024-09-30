extends CharacterBody2D

##Signals
signal taken_damage # talks to HUD
#picked up time

@export var speed:int = 300
@export var health:int = 0
@export var magic_points:int = 50
@export var dash_speed:int = 10

var current_weapon:Weapon_Pickup.WEAPON

var input_dir:Vector2 = Vector2.ZERO
var last_dir:Vector2 = Vector2.ZERO

var dash_dir:Vector2 = Vector2.ZERO
var can_dash:bool = true

var is_invincible:bool = false

##PreLoad Scenes
@export var range_attack_scene:PackedScene = preload("res://Scenes/arrow.tscn")
@export var melee_attack_scene:PackedScene = preload("res://Scenes/sword.tscn")

##Nodes vars to instantiate attack scenes in
var melee:Node

func _ready():
	#Instantiate attack scenes
	#add them as children
	melee = melee_attack_scene.instantiate()
	add_child(melee)

func _process(delta):
	orient()

func _physics_process(delta):
	input_dir = Input.get_vector("left","right","up","down");
	
	if input_dir != Vector2.ZERO:
		last_dir = input_dir
	
	input_dir = input_dir.normalized()
	
	
	velocity = input_dir * speed
	move_and_collide(velocity * delta)

#clean this up later
func _input(event): #replace with match?
	if event.is_action_pressed("dash") and can_dash:
		dash()
	if event.is_action_pressed("weapon_attack"):
		weapon_attack()
	if event.is_action_pressed("interact"):
		for area in $HurtBox.get_overlapping_areas(): #might run into problem where two weapons are on top of each other
			if area.is_in_group("Weapon_Pickup"):
				current_weapon = area.weapon_type
				print(current_weapon)


func dash():
	speed += 300
	can_dash = false
	is_invincible = true
	velocity = input_dir * dash_speed
	await get_tree().create_timer(0.5).timeout
	speed = 300
	can_dash = true
	is_invincible = false

# Would like to decouple this later
func weapon_attack():
	match current_weapon:
		Weapon_Pickup.WEAPON.SWORD:
			melee_attack()
		Weapon_Pickup.WEAPON.BOW:
			ranged_attack()

func melee_attack():
	melee.activate($AttackOrigin)

func ranged_attack():
	var projectile = range_attack_scene.instantiate()
	projectile.initialize($AttackOrigin.global_position, last_dir.angle())
	get_parent().add_child(projectile)
	projectile.activate($AttackOrigin)

func magic_attack():
	pass

func hit(amount):
	print("taken_damage")
	taken_damage.emit()
	#modify health

func orient():
	#80 is from center of player to edge of player 
	##TODO get rid of magic number 80
	$AttackOrigin.position = 80 * last_dir
	$AttackOrigin.rotation = last_dir.angle()
