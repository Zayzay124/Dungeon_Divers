class_name Blob_Attack
extends Enemy_Attack

@export var speed:int = 500

var velocity:Vector2 = Vector2.ZERO

func _ready():
	super._ready()

## Constructor
func initialize(origin:Vector2, angle:float):
	global_position = origin
	self.rotation = angle
	velocity = speed * Vector2.RIGHT.rotated(angle)

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position += velocity * delta

func activate(_origin):
	visible = true
	$Detector.disabled = false

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
