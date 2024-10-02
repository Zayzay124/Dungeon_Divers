extends Node
class_name EnemyState

signal transitioned

@export var enemy: CharacterBody2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var anim_player = get_parent().get_parent().get_node("AnimationPlayer")

var player_direction: Vector2


func enter():
	pass

func exit():
	pass

func update(_delta):
	pass

func physics_update(_delta):
	pass
