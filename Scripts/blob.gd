extends CharacterBody2D
#possibly create enemy class

@export var speed = 300.0


func _physics_process(delta):
	if velocity.x>0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
	
	move_and_slide()

func _on_shoot():
	pass #
