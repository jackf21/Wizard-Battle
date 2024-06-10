class_name Player

extends Entity

var equipeed_spells: Array[Spell]

@export var projectile_scene: PackedScene
@export var health_label: Label

@onready var shoot_cooldown = $ShootCooldown
@onready var face = $Face

func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	velocity.normalized()
	move_and_slide()

func _process(_delta):
	look_at(get_global_mouse_position())
	health_label.text = str(current_health)

func _input(event):
	if event.is_action_pressed("shoot_primary"):
		return

