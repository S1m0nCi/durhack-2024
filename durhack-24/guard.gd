extends CharacterBody2D

var chase_speed = 25
var track_speed = chase_speed/3
var player_chase = false
var player_track = false
# TO DO: add a larger detection area for each guard to be able to track the player rather than chase: ie a slower speed
var player = null

func _physics_process(delta: float) -> void:
	if player_chase:
		position += (player.position - position)/chase_speed
		$AnimatedSprite2D.play("walk_front")
		
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle_front")

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body # player is the body that has entered
	player_chase = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	# attempting to make a chase for a 
	player = null
	player_chase = false
	player_track = true
	# when player exits detection, can hide again.
	# could be related to torchlight or more complicated.
