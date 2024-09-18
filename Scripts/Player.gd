extends CharacterBody2D

##Signals
signal taken_damage # talks to HUD
#picked up tiem

@export var speed:int = 300
@export var health:int = 0
@export var magic_points:int = 50

var input_dir:Vector2 = Vector2.ZERO

var is_invincible:bool = false

##PreLoad Scenes
#load melee attack scene

##Nodes vars to instantiate attack scenes in

func _ready():
	#Instantiate attack scenes
	#add them as children
	pass

func _process(delta):
	pass

func _physics_process(delta):
	input_dir = Input.get_vector("left","right","up","down");
	velocity = input_dir * speed
	
	move_and_collide(velocity * delta)

func dash():
	#velocity += Vector2(brenden's answer)
	get_tree().create_timer(.75)
	pass

func weapon_attack():
	pass

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
