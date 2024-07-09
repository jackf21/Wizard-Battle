extends Node

const BASIC_PROJECTILE_SCENE = preload("res://Scenes/basic_projectile.tscn")

var shoot_ready := true

@onready var player = $".."
@onready var shoot_cooldown = $shoot_cooldown

func cast_spell(id):
	match id:
		0:
			cast_basic_projectile()
		1:
			cast_fire_projectile()
		_:
			print("Id not recognised or is nil")

func _on_shoot_cooldown_timeout():
	shoot_ready = true

func cast_basic_projectile():
	#print("Casting basic projectile")
	shoot_ready = false
	var basic_projectile = BASIC_PROJECTILE_SCENE.instantiate()
	get_tree().get_root().add_child(basic_projectile)
	basic_projectile.position = player.face.global_position
	basic_projectile.rotation = player.rotation
	shoot_cooldown.start()
	#print("Basic projectile casted")

func cast_fire_projectile():
	print("Casting fire projectile")
	shoot_ready = false
	var basic_projectile = BASIC_PROJECTILE_SCENE.instantiate()
	get_tree().get_root().add_child(basic_projectile)
	basic_projectile.position = player.face.global_position
	basic_projectile.rotation = player.rotation
	basic_projectile.spell_damage_type = "FIRE"
	shoot_cooldown.start()
