extends Spell

const SPEED: float = 600

signal projectile_spell_casted

@onready var lifespan = $Lifespan
@onready var player = $"../player"

@export var spell_damage: float
@export var spell_damage_type: damage_types

func _ready():
	lifespan.start()

func _on_lifespan_timeout():
	queue_free()

func _physics_process(delta):
	position += transform.x * SPEED * delta

func _on_body_entered(body):
	if body.has_method("damage_entity"):
		body.damage_entity(spell_damage, spell_damage_type)
	queue_free()
