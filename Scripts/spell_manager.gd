extends Node

const BASIC_PROJECTILE_SCENE = preload("res://Scenes/basic_projectile.tscn")

var shoot_ready := true

@onready var player = $".."
@onready var face = $"../face"
@onready var shoot_cooldown = $shoot_cooldown

var mapIdToSpellDict = {
	0: "cast_untyped_projectile",
	1: "cast_fire_projectile"
}

func cast_spell(id):
	
	# looks up ID in dictionary, return null if not found
	var functionName = mapIdToSpellDict.get(id, null)
	
	if functionName == null:
		print("Spell ID not found in dictionary.")
		return
	
	# calls appropriate spell function
	call(functionName)

func _on_shoot_cooldown_timeout():
	shoot_ready = true

# Basic projectile is what is fired by everything else, but is edited based on what is needed individually by other projectiles
# This is NOT a projectile that can be fired itself!
func cast_basic_projectile(projectile_scene):
	shoot_ready = false
	get_tree().get_root().add_child(projectile_scene)
	projectile_scene.position = face.global_position
	projectile_scene.rotation = player.rotation
	shoot_cooldown.start()

func cast_untyped_projectile():
	print("Casting basic projectile")
	var basic_projectile = BASIC_PROJECTILE_SCENE.instantiate()
	cast_basic_projectile(basic_projectile)
	#var test = basic_projectile.get_node("Untyped_sprite")
	#if (test == null):
	#print("basic projectile sprite has not instanced")
	basic_projectile.get_node("Untyped_sprite").visible = true

func cast_fire_projectile():
	print("Casting fire projectile")
	var basic_projectile = BASIC_PROJECTILE_SCENE.instantiate()
	cast_basic_projectile(basic_projectile)
	basic_projectile.spell_damage_type = "FIRE"
	basic_projectile.get_node("Fire_sprite").visible = true
