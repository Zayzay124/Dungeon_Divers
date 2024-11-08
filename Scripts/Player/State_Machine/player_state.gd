class_name PlayerState
extends Node

signal transitioned

@export var player: CharacterBody2D

@onready var anim_player = get_parent().get_parent().get_node("AnimationPlayer")

func enter():
	pass

func exit():
	pass

func update(_delta):
	pass

func physics_update(_delta):
	fall_check()
	print("thing")

func player_movement():
	player.velocity = player.input_dir * player.speed

#put fall check here
func fall_check():
	if player.has_fallen:
		transitioned.emit(self,"fall")
