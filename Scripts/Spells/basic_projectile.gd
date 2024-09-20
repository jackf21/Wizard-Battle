#Scene used for any projectile spells that have no effect on bit other than an elemental effect

extends Spell

var speed: float = 1000
var lifespan_time: float = 5

@export var spell_damage: float
@export var spell_damage_type: damage_types

@onready var lifespan = $Lifespan

func _ready():
	lifespan.start(lifespan_time)

func _on_lifespan_timeout():
	queue_free()

func _physics_process(delta):
	var collision = move_and_collide(velocity * speed * delta)
	if (collision):
		#
		# Will always queue free on collision
		#
		if collision.get_collider().has_method("damage_entity"):
			collision.get_collider().damage_entity(spell_damage, spell_damage_type)
		queue_free()

func  cast_untyped_projectile() -> void:
	get_node("ball_hitbox").visible = true
	get_node("Untyped_sprite").visible = true

func cast_fire_projectile() -> void:
	get_node("ball_hitbox").visible = true
	get_node("Fire_sprite").visible = true

func cast_spear_projectile() -> void:
	get_node("spear_collider").visible = true
	get_node("Spear_sprite").visible = true
