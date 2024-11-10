class_name EnemyState
extends Node

signal transitioned

@export var enemy:CharacterBody2D

@onready var player:CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var anim_player = get_parent().get_parent().get_node("AnimationPlayer")


func enter():
	pass

func exit():
	pass

func update(_delta):
	pass

func physics_update(_delta):
	pass

func player_detection():
	return enemy.player_in_range and enemy.LOS_of_player
