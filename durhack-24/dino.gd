extends CharacterBody2D

var caught = false
var caught_valid = false

func _on_dino_win_body_entered(player: Player) -> void:
	player.won = true
	print ("You win!")
