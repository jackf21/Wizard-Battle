extends CharacterBody2D

const SPEED := 400
const BASIC_PROJECTILE = preload("res://Scenes/basic_projectile.tscn")

var shoot_ready: bool = true
@onready var shoot_cooldown = $ShootCooldown
@onready var face = $Face

func _input(event):
	if event.is_action_pressed("shoot_primary") and shoot_ready:
		shoot_ready = false
		var basic_projectile = BASIC_PROJECTILE.instantiate()
		get_parent().add_child(basic_projectile)
		basic_projectile.position = face.global_position
		basic_projectile.rotation = rotation
		shoot_cooldown.start()
		
func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	velocity.normalized()
	move_and_slide()

func _process(_delta):
	look_at(get_global_mouse_position())

func _on_shoot_cooldown_timeout():
	shoot_ready = true
