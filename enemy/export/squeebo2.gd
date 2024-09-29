extends CharacterBody2D  # Inherit from CharacterBody2D since it handles movement and collisions.

# Variables
var speed: float = 100  # Movement speed
var attack_range: float = 50  # Distance to start attacking
var damage: int = 20  # Damage to deal
var is_attacking: bool = false  # Whether the Squeebo is attacking
var player: Node = null  # Reference to the player
var attack_timer: float = 1.5  # Attack cooldown time

# Runs when the game starts
func _ready():
	player = get_node("/root/MainScene/squeebo2")  # Replace this with the path to your player node
	$Timer.connect("timeout", Callable(self, "_on_Timer_timeout"))  # Connect timer timeout signal to attack function

# This function runs every frame
func _physics_process(delta: float) -> void:
	if player:
		move_towards_player(delta)

# Move towards the player
func move_towards_player(delta: float) -> void:
	var direction = (player.global_position - global_position).normalized()  # Get direction to the player
	var distance_to_player = global_position.distance_to(player.global_position)

	if distance_to_player > attack_range:
		var velocity = direction * speed  # Calculate the velocity
		move_and_slide()  # Move towards the player
	else:
		attack_player()  # If close, attack

# Attack function
func attack_player() -> void:
	if not is_attacking:
		is_attacking = true
		$Timer.start(attack_timer)  # Start the attack timer
		$AnimationPlayer.play("attack")  # Play the attack animation

# Called when the attack timer finishes
func _on_Timer_timeout() -> void:
	if is_attacking:
		deal_damage_to_player()
		is_attacking = false

# Deal damage if player is close enough
func deal_damage_to_player() -> void:
	var distance_to_player = global_position.distance_to(player.global_position)
	if distance_to_player <= attack_range:
		player.take_damage(damage)
