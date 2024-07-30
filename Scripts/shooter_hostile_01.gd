class_name Shooter_hostile

extends Entity

var move_state: int

@export var min_player_dist := 500
@export var max_player_dist := 600

@onready var player = $"../player"

func _ready():
	print(global_position.distance_to(player.global_position))

func _process(_delta):
	var player_position = player.global_position
	var distance_to_player = global_position.distance_to(player_position)
	
	#
	# Figure out if the enemy is moving to the max or min
	#
	if (move_state == 0):
		if (distance_to_player < min_player_dist):
			move_state == -1 # Player is too close, move towards max
		else:
			move_state == 1 # player is too far away, move towards max
	elif (move_state == -1):
		global_position = global_position.move_toward(player_position, speed)
