extends CharacterBody2D

##Signals
signal taken_damage # talks to HUD
#picked up time

@export var speed:int = 300
@export var health:int = 0
@export var magic_points:int = 50
@export var dash_speed:int = 10


var input_dir:Vector2 = Vector2.ZERO

var dash_dir:Vector2 = Vector2.ZERO
var can_dash:bool = true

var is_invincible:bool = false

##PreLoad Scenes
@export var range_attack:PackedScene = preload("res://Scenes/arrow.tscn")
@export var melee_attack:PackedScene = preload("res://Scenes/sword.tscn")

##Nodes vars to instantiate attack scenes in
var melee:Node

func _ready():
	#Instantiate attack scenes
	#add them as children
	melee = melee_attack.instantiate()
	add_child(melee)


func _process(delta):
	pass

func _physics_process(delta):
	input_dir = Input.get_vector("left","right","up","down");
	
	if Input.is_action_pressed("right") || Input.is_action_pressed("left"):
		input_dir.y = 0
	elif Input.is_action_pressed("up") || Input.is_action_pressed("down"):
		input_dir.x = 0
	else:
		input_dir = Vector2.ZERO
	
	input_dir = input_dir.normalized()
	
	velocity = input_dir * speed
	move_and_collide(velocity * delta)

func _input(event):
	if event.is_action_pressed("dash") and can_dash:
		dash()
	if event.is_action_pressed("weapon_attack"):
		weapon_attack()

func dash():
	speed += 300
	can_dash = false
	is_invincible = true
	velocity = input_dir * dash_speed
	$DashTimer.start()

func weapon_attack():
	#activate melee attacks
	print("attask")
	#initialize ranged attack
	#use $AttackOrigin to initialize attack
	var projectile = range_attack.instantiate()
	projectile.initialize($AttackOrigin.global_position, self.rotation)
	get_parent().add_child(projectile)
	projectile.activate()

func magic_attack():
	pass

func hit(amount):
	print("taken_damage")
	taken_damage.emit()
	#modify health

##Collision check
#when invincible is true



func _on_hurtbox_body_entered(body):
	if body.is_in_group("enemy") and not is_invincible:
		#hit(body.get_damage())
		pass
	pass


func _on_dash_timer_timeout():
	speed = 300
	can_dash = true
	is_invincible = false
