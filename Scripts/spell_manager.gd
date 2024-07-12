extends Node

const BASIC_PROJECTILE_SCENE = preload("res://Scenes/basic_projectile.tscn")

var shoot_ready := true

@onready var player = $".."
@onready var shoot_cooldown = $shoot_cooldown

func cast_spell(id):
	match id:
		0:
			cast_untyped_projectile()
		1:
			cast_fire_projectile()
		_:
			print("Id not recognised or is nil")

func _on_shoot_cooldown_timeout():
	shoot_ready = true

func cast_basic_projectile(projectile_scene):
	shoot_ready = false
	get_tree().get_root().add_child(projectile_scene)
	projectile_scene.position = player.face.global_position
	projectile_scene.rotation = player.rotation
	shoot_cooldown.start()

func cast_untyped_projectile():
	print("Casting basic projectile")
	var basic_projectile = BASIC_PROJECTILE_SCENE.instantiate()
	cast_basic_projectile(basic_projectile)
	basic_projectile.Untyped_sprite.visible = true

func cast_fire_projectile():
	print("Casting fire projectile")
	var basic_projectile = BASIC_PROJECTILE_SCENE.instantiate()
	cast_basic_projectile(basic_projectile)
	basic_projectile.spell_damage_type = "FIRE"
	#$Fire_sprite.show()
