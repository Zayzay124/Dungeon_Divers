extends CharacterBody2D

const speed:int = 65


@export var blob_attack_scene:PackedScene = preload("res://Scenes/blob_attack.tscn")
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var LOS:RayCast2D = $LOS

var pushback:int = 1000
var player_direction:Vector2

var LOS_of_player:bool = false
var player_in_range:bool = false
var can_attack:bool = false

func _process(delta):
	LOS.target_position = player_direction
	player_direction = player.global_position - global_position
	LOS_of_player = !LOS.is_colliding()

func _physics_process(_delta):
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
	move_and_slide()

func hit(_amount):
	queue_free()
