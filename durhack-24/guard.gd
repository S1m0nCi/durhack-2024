extends CharacterBody2D

var chase_speed = 70
var patrol_speed = chase_speed*3
var player_chase = false
var player_track = false
# TO DO: add a larger detection area for each guard to be able to track the player rather than chase: ie a slower speed
var player = null
var caught = false
var rng = RandomNumberGenerator.new()

func _physics_process(delta: float) -> void:
	if player_chase:
		position += (player.position - position)/chase_speed
		$AnimatedSprite2D.play("side")
		
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	elif caught:
		# player.caught = true
		print ("Game Over")
		# player is caught
	else:
		# patrol
		print ("Should be Patrolling")
		$AnimatedSprite2D.play("side")
		patrol()
		await get_tree().create_timer(5).timeout
		$AnimatedSprite2D.play("front")
		await get_tree().create_timer(5).timeout
		
func patrol():
	var x_direction = rng.randf_range(-10.0, 10.0)
	var y_direction = rng.randf_range(-10.0, 10.0)
	position += (position + Vector2(x_direction, y_direction))/patrol_speed

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


func _on_caught_area_body_entered(body: Node2D) -> void:
	var bin_layer = body.get_collision_layer()
	if bin_layer == 5:
		player = body
		player_chase = false
		caught = true
