extends CharacterBody2D

# Code based on the DevWorm RPG Godot Tutorial, with a few Durheist modifications.

const speed = 100
var current_direction = "none"

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta: float) -> void:
	player_move(delta)	
	
func player_move(delta):
	if Input.is_action_pressed("ui_right"):
		current_direction = "right"
		play_anim(1) # Play walk animation
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_direction = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_direction = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		current_direction = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_anim(0)
		velocity.x = 0 # If no key is pressed, player should not move.
		velocity.y = 0
	
	move_and_slide()

func play_anim(movement):
	var dir = current_direction
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false # Do not flip animation, faces right by default
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "left":
		anim.flip_h = true # Flip animation, faces right by default
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "up":
		anim.flip_h = false # Do not flip animation, faces right by default
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")
	if dir == "down":
		anim.flip_h = false # Do not flip animation, faces right by default
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("idle")
