extends CharacterBody2D

# Code based on the DevWorm RPG Godot Tutorial, with a few Durheist modifications.

const speed = 225
var current_direction = "none"
var caught = false

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta: float) -> void:
	if not caught:
		player_move(delta)
	else:
		pass
		
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
			anim.play("side")
		elif movement == 0:
			anim.play("side")
	if dir == "left":
		anim.flip_h = true # Flip animation, faces right by default
		if movement == 1:
			anim.play("side")
		elif movement == 0:
			anim.play("side")
	if dir == "up":
		anim.flip_h = false # Do not flip animation, faces right by default
		if movement == 1:
			anim.play("back")
		elif movement == 0:
			anim.play("back")
	if dir == "down":
		anim.flip_h = false # Do not flip animation, faces right by default
		if movement == 1:
			anim.play("front")
		elif movement == 0:
			anim.play("front")
