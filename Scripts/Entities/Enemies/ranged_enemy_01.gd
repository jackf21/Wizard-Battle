# TODO:
# Enemy moves towards the player when too close
# Enemy direction of shooting has the same skew as the player shooting when moving
#	Fixing player first would help?
# Add delay to the rotation of the enemy

extends Entity

const BASIC_PROJECTILE_SCENE = preload("res://Scenes/basic_projectile.tscn")

var move_state := 0
var shooting_cooldown: float = 2
var shoot_ready := true 

# Max and minimun distance the enemy should be away from the player (needs tweaking)
var rand_dist_from_player := randi_range(375, 450)
@export var min_player_dist := 400
@export var max_player_dist := 450

@onready var player = $"../player"
@onready var face: Marker2D = $face

# Timer between shots
@onready var shoot_cooldown: Timer = $shoot_cooldown

func _process(_delta) -> void:
	var player_position = player.global_position
	var distance_to_player = global_position.distance_to(player_position)
	#look_at(player_position)
	#This is the same as look_at(player_position) but is needed for adding the delay
	rotate((to_local(player_position) * get_scale()).angle())
	
	if (distance_to_player > rand_dist_from_player):
		velocity = position.direction_to(player_position) * speed
		move_and_slide()
	else:
		shooting_mode(shooting_cooldown)


# Moving the enemy based on its distance to the player
# Not used at the moment, enemy will work with what it uses now
# Could use improving, not high priority
func  movement_mode(player_position, distance_to_player) -> void:
	
	#
	# Figure out if the enemy is moving to the max or min
	# move_state must be either 1, 0 or -1
	#
	if (move_state == 0):
		#print("Neutral move state")
		#print("Deciding direction of movement")
		if (distance_to_player < min_player_dist):
			move_state = -1 # Player is too close, move towards max
		else:
			move_state = 1 # Player is too far away, move towards min
	#
	# Move towards min
	#
	elif (move_state == 1):
		#print("Moving towards player")
		velocity = position.direction_to(player_position) * speed
		move_and_slide()
		
		if (distance_to_player >= min_player_dist):
			move_state = 0 
			return # Resets the movestate as the player is now too close
	#
	# Move towards max
	#
	elif (move_state == -1):
		#print("Moving away from player")
		velocity = position.direction_to(player_position) * -1 * speed
		move_and_slide()
		
		if (distance_to_player >= max_player_dist):
			move_state = 0 
			return # Resets the movestate as the player is now too far away

# Shooting at the player
func shooting_mode(cooldown_time: float) -> void:
	var basic_projectile = BASIC_PROJECTILE_SCENE.instantiate()
	
	if (shoot_ready):
		#print("Shooting at player")
		shoot_cooldown.start(cooldown_time)
		shoot_ready = false
		get_tree().get_root().add_child(basic_projectile)
		basic_projectile.position = face.global_position
		#basic_projectile.rotation = rotation
		basic_projectile.velocity = global_position.direction_to(face.global_position)
		basic_projectile.speed = 400
		basic_projectile.get_node("Untyped_sprite").visible = true

func _on_shoot_cooldown_timeout() -> void:
	shoot_ready = true
