extends CharacterBody2D

var chase_speed = 35
var patrol_offset = 5
var player_chase = false
var player_track = false
# TO DO: add a larger detection area for each guard to be able to track the player rather than chase: ie a slower speed
var player = null
var rng = RandomNumberGenerator.new()
var counter = 0
var patrol_interval = 250

var x_direction = rng.randf_range(-10.0, 10.0)
var y_direction = rng.randf_range(-10.0, 10.0)
var forward_patrol = true

var is_player = false

func _physics_process(delta: float) -> void:
	if player_chase:
		position += (player.position - position)/chase_speed
		$AnimatedSprite2D.play("side")
		
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		# player is caught
	else:
		counter += 1
		if counter >= patrol_interval:
			patrol(x_direction, y_direction)
		
func patrol(x_direction, y_direction):
	counter += 1
	if counter >= 2*patrol_interval:
		counter = 0
		forward_patrol = not forward_patrol
	else:
		if forward_patrol:
			position += (Vector2(x_direction, y_direction))/patrol_offset
		else:
			position += (Vector2(-x_direction, -y_direction))/patrol_offset
			

func _on_detection_area_body_entered(body: Player) -> void:
	player = body # player is the body that has entered
	player_chase = true


func _on_detection_area_body_exited(player: Player) -> void:
	# attempting to make a chase for a 
	player = null
	player_chase = false
	player_track = true
	# when player exits detection, can hide again.
	# could be related to torchlight or more complicated.


func _on_caught_area_body_entered(body: Player) -> void:
	player = body
	player_chase = false
	player.caught = true
