#Large projectie that explodes into a larger hitbox on collision

extends Spell

var speed: float = 1000
var lifespan_time: float = 5

@export var spell_damage: float
@export var spell_damage_type: damage_types

@onready var lifespan = $lifespan

func _ready() -> void:
	lifespan.start(lifespan_time)

func _on_lifespan_time_timeout() -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	# Requires move and collide for explosion
	var collision = move_and_collide(velocity * speed * delta)
	if (collision):
		#Stop projectile to prevent explosion hitbox from moving
		velocity = Vector2(0,0)
		get_node("explosion_hitbox").visible = true
		get_node("Fireball_explosion_sprite").visible = true
		get_node("projectile_hitbox").visible = true
		get_node("Fireball_sprite").visible = true
		#
		# Will always queue free on collision
		#
		if collision.get_collider().has_method("damage_entity"):
			collision.get_collider().damage_entity(spell_damage, spell_damage_type)
		#queue_free()
