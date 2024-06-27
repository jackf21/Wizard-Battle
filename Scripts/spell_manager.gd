extends Node

const BASIC_PROJECTILE_SCENE = preload("res://Scenes/basic_projectile.tscn")

var shoot_ready := true

@onready var player = $".."
@onready var shoot_cooldown = $shoot_cooldown
@onready var node_2d = $"."

func cast_spell(id):
	match id:
		0:
			cast_basic_projectile()
		_:
			print("Id not recognised or is nil")

func cast_basic_projectile():
	#print("Casting basic projectile")
	shoot_ready = false
	var basic_projectile = BASIC_PROJECTILE_SCENE.instantiate()
	node_2d.add_child(basic_projectile)
	basic_projectile.position = player.face.global_position
	basic_projectile.rotation_degrees = player.rotation_degrees
	shoot_cooldown.start()
	#print("Basic projectile casted")

func _on_shoot_cooldown_timeout():
	shoot_ready = true
