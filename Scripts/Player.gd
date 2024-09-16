extends CharacterBody2D

##Signals
#taken_damage # talks to HUD
#picked up tiem

@export var speed:int = 300
@export var health:int = 0
@export var magic_points:int = 50

var input_dir:Vector2 = Vector2.ZERO

##PreLoad Scenes
#load melee attack scene

##Nodes vars to instantiate attack scenes in

func _ready():
	#Instantiate attack scenes
	#add them as children
	pass

func _physics_process(delta):
	input_dir = Input.get_vector("left","right","up","down");
	velocity = input_dir * speed
	
	move_and_collide(velocity * delta)

func dash():
	pass

func weapon_attack():
	pass

func magic_attack():
	pass
