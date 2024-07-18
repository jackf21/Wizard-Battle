class_name Shooter_hostile

extends Entity

@onready var player = $"../player"

#func _ready():
#	print(player.transform)

func _process(delta):
	var player_position = player.transform
	var entity_position = transform
	
	var dist_to_player = entity_position.x - player_position.x
