class_name Enemy
extends CharacterBody2D

@export var speed:int = 50
@export var health:int = 0

@export var attack_scene:PackedScene

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var LOS:RayCast2D = $LOS

var player_direction:Vector2

var LOS_of_player:bool = false
var player_in_range:bool = false
var can_attack:bool = false

func _process(_delta):
	LOS.target_position = player_direction
	player_direction = player.global_position - global_position
	LOS_of_player = !LOS.is_colliding()

func _physics_process(_delta):
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
	move_and_slide()

func hit(knockback_force, direction, damage_amount):
	velocity += (knockback_force * get_vector_from_angle(direction)) #take knockback
	health -= damage_amount
	if health <= 0:
		die()

func die():
	queue_free()

func get_vector_from_angle(angle):
	var x = cos(angle)
	var y = sin(angle)
	return Vector2(x, y)
