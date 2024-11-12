extends Control

# Reference to the Tutorial and Credits popups
@onready var tutorial_popup = $VBoxContainer/TutorialButton/TutorialPopup
@onready var credits_popup = $VBoxContainer/CreditsButton/CreditsPopup

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level.tscn")

func _on_tutorial_button_pressed() -> void:
	tutorial_popup.popup_centered()  # Shows the tutorial popup in the center

func _on_tutorial_exit_button_pressed() -> void:
	tutorial_popup.hide()
	
func _on_credits_button_pressed() -> void:
	credits_popup.popup_centered()  # Shows the tutorial popup in the center

func _on_credits_exit_button_pressed() -> void:
	credits_popup.hide()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
