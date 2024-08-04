extends Spell

var speed: float = 50
var player

@export var spell_damage: float
@export var spell_damage_type: damage_types

@onready var lifespan = $Lifespan

func _ready():
	lifespan.start(5)

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
