extends Control

func _ready():
	$ProgressBar.value = 16

func _on_player_damaged(damage):
	print("idk")
	$ProgressBar.value -= damage
	
