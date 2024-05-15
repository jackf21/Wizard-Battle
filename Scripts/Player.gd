extends CharacterBody2D

const SPEED := 400

var mouse_position: Vector2

func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	velocity.normalized()
	move_and_slide()

func _process(_delta):
	look_at(get_global_mouse_position())
