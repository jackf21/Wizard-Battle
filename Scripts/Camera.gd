extends Camera2D

@onready var player: CharacterBody2D = $"../player"

func _process(_delta):
	var mouse_pos := get_global_mouse_position()
	var dist_to_mouse := mouse_pos - player.position
	var desired_pos := player.position + dist_to_mouse / 4
	position = desired_pos
