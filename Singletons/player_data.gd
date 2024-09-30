extends Node

var PLAYER_PATH = "res://Scenes/player.tscn"

var player_current_health: int
var player_current_level: int

var player_posiiton: Vector2

signal enemy_has_died(enemy_name)

signal player_has_leveled_up
