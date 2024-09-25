extends Spell

var speed: float = 600
var lifespan_time: float = 5
var single_collision_effects_occured: bool = false

@export var spell_damage: float

@onready var explosion_collision = $explosion_area/explosion_collision
@onready var lifespan = $Lifespan
@onready var explosion_duration: Timer = $Explosion_duration

func _ready() -> void:
	lifespan.start(lifespan_time)

func _on_lifespan_timeout() -> void:
	if(!single_collision_effects_occured):
		queue_free()

func _on_explosion_duration_timeout() -> void:
	queue_free()

func _physics_process(delta) -> void:
	var collision = move_and_collide(velocity * speed * delta)
	if (collision):
		velocity = Vector2(0,0)
		
		if(!single_collision_effects_occured):
			get_node("projectile_collision").set_deferred("disabled", true)
			get_node("Fireball_sprite").visible = false
			
			explosion_collision.set_deferred("disabled", false)
			get_node("Explosion_sprite").visible = true
			explosion_duration.start(1)
			single_collision_effects_occured = true
		#
		# Will always queue free on collision
		#
		if collision.get_collider().has_method("damage_entity"):
			collision.get_collider().damage_entity(spell_damage, spell_damage_type)
		#queue_free()
