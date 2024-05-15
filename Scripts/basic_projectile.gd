extends CharacterBody2D

const SPEED: float= 600

@onready var lifespan = $Lifespan

func _ready():
	lifespan.start()

func _on_lifespan_timeout():
	queue_free()

func _physics_process(_delta):
	velocity = global_transform.x * SPEED
	move_and_slide()
