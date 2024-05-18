extends Area2D

const SPEED: float= 600

@onready var lifespan = $Lifespan

func _ready():
	lifespan.start()

func _on_lifespan_timeout():
	queue_free()

func _physics_process(delta):
	position += transform.x * SPEED * delta
