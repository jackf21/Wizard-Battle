extends Node

const BASIC_PROJECTILE_SCENE = preload("res://Scenes/basic_projectile.tscn")

var shoot_ready := true

@onready var player = $"../player"
@onready var shoot_cooldown = $shoot_cooldown

func cast_spell(id):
	return

func cast_basic_projectile():
	shoot_ready = false
	var basic_projectile = BASIC_PROJECTILE_SCENE.instantiate()
	get_parent().add_child(basic_projectile)
	basic_projectile.position = player.face.global_position
	basic_projectile.rotation = player.rotation
	basic_projectile.number_of_uses -= 1
	shoot_cooldown.start()

func _on_shoot_cooldown_timeout():
	shoot_ready = true
