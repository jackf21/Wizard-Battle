class_name Player

extends Entity

@export var equiped_spell_ids: Array[int]
@export var health_label: Label

@onready var spell_manager = $"Spell Manager"

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
		spell_manager.cast_spell(equiped_spell_ids[0])
	if event.is_action_pressed("shoot_secondary"):
		spell_manager.cast_spell(equiped_spell_ids[1])
	#if event.is_action_pressed("shoot_tertiary"):
		#spell_manager.cast_spell(equiped_spell_ids[2])
	#if event.is_action_pressed("shoot_quaternary"):
		#spell_manager.cast_spell(equiped_spell_ids[3]) 
