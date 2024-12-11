class_name Attack
extends Area2D

@export var damage:int = 1
@export var knockback_force:int = 1200

@export var startup_time:float = 0
@export var activation_time:float = 0
@export var recovery_time:float = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func activate(origin):
	position = origin.position
	rotation = origin.rotation
	visible = true
	$AnimatedSprite2D.play("attack")
	await get_tree().create_timer(startup_time).timeout
	$Detector.disabled = false
	await get_tree().create_timer(activation_time).timeout
	recover()


func recover():
	$Detector.disabled = true
	await get_tree().create_timer(recovery_time).timeout
	stop()

func stop():
	visible = false


func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.knockback(knockback_force,rotation,damage)
		body.hit(damage)
