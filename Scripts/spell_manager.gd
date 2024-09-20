# TODO:
# # Fix direction of shots being skewed when moving
# Changing collision layer and mask depending of whether the projectile is from the player or an enemy
# MORE SPELLS
# Large fireball that explodes on impact 
# Raycast beam to the mouse position 
# Piercing ice bolt

extends Node

const BASIC_PROJECTILE_SCENE = preload("res://Scenes/Projectiles/basic_projectile.tscn")
const EXPLOSIVE_PROJECTILESCENE = preload("res://Scenes/Projectiles/explosive_projectile.tscn")

var shoot_ready := true
var shoot_cooldown_time: float = 1

@onready var player = $".."
@onready var face = $"../face"
@onready var shoot_cooldown = $shoot_cooldown

var mapIdToSpellDict = {
	0: "cast_untyped_projectile",
	1: "cast_fire_projectile",
	2: "cast_explosive_fireball"
}

func cast_spell(id):
	if (shoot_ready):
		shoot_cooldown.start(shoot_cooldown_time)
		shoot_ready = false
		# looks up ID in dictionary, return null if not found
		var functionName = mapIdToSpellDict.get(id, null)
		
		if functionName == null:
			print("Spell ID not found in dictionary.")
			return
		
		# calls appropriate spell function
		call(functionName)
	else:
		print("Shoot not ready")
		return

func _on_shoot_cooldown_timeout():
	shoot_ready = true

# Basic projectile is what is fired by everything else, but is edited based on what is needed individually by other projectiles
# This is NOT a projectile that can be fired itself!
func cast_projectile(projectile_scene):
	get_tree().get_root().add_child(projectile_scene)
	projectile_scene.position = face.global_position
	#projectile_scene.rotation = player.rotation
	projectile_scene.velocity = player.global_position.direction_to(face.global_position)

func cast_untyped_projectile():
	print("Casting basic projectile")
	var basic_projectile = BASIC_PROJECTILE_SCENE.instantiate()
	cast_projectile(basic_projectile)
	#var test = basic_projectile.get_node("Untyped_sprite")
	#if (test == null):
	#print("basic projectile sprite has not instanced")
	basic_projectile.change_projectile_to_player()
	basic_projectile.cast_untyped_projectile()

func cast_fire_projectile():
	print("Casting fire projectile")
	var basic_projectile = BASIC_PROJECTILE_SCENE.instantiate()
	cast_projectile(basic_projectile)
	basic_projectile.spell_damage_type = "FIRE"
	basic_projectile.change_projectile_to_player()
	basic_projectile.cast_fire_projectile()

func cast_explosive_fireball():
	var explosive_projectile = EXPLOSIVE_PROJECTILESCENE.instantiate()
	cast_projectile(explosive_projectile)
