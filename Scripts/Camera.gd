extends Camera2D

@export var player: CharacterBody2D
const SMOOTH_SPEED: float = 5

func _process(_delta):
	var mouse_pos := get_global_mouse_position()
	
	var desired_pos := player.position / 4 + mouse_pos / 4
	position = desired_pos
