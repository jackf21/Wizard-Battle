class_name Shooter_hostile

extends Entity

var move_state := 0

@export var min_player_dist := 300
@export var max_player_dist := 500

@onready var player = $"../player"

func _process(delta):
	var player_position = player.global_position
	var distance_to_player = global_position.distance_to(player_position)
	#
	# Figure out if the enemy is moving to the max or min
	# move_state must be either 1, 0 or -1
	#
	if (move_state == 0):
		if(distance_to_player > min_player_dist && distance_to_player <  max_player_dist):
			return
		elif (distance_to_player < min_player_dist):
			move_state = -1 # Player is too close, move towards max
		else:
			move_state = 1 # Player is too far away, move towards min
	#
	# Move towards min
	#
	elif (move_state == 1):
		print("Moving towards player")
		velocity = position.direction_to(player_position) * speed
		move_and_slide()
		
		if (distance_to_player >= min_player_dist):
			move_state = 0 
			return # Resets the movestate as the player is now too close
	#
	# Move towards max
	#
	elif (move_state == -1):
		print("Moving away from player")
		velocity = (position.direction_to(player_position) * -1) * speed
		move_and_slide()
		
		if (distance_to_player <= max_player_dist):
			move_state = 0 
			return # Resets the movestate as the player is now too far away
