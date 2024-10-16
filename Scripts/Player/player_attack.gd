class_name Player_Attack
extends PlayerState

signal attacking

func enter():
	print("player attack")
	attacking.emit()
