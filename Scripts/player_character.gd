# TODO
# Have the point the player is looking at be a node which is modified by both moving the player and the mouse (like hotline miami)
# Fix direction of shots being skewed when moving

class_name Player

extends Entity

@export var equipped_spell_ids: Array[int]
@export var health_label: Label

@onready var spell_manager = $"Spell Manager"


var current_lvl: int = 0
var current_xp_amount: int = 0
var xp_for_lvlup: int = 100


func _ready() -> void:
	RunningPlayerData.enemy_has_died.connect(_on_enemy_died)


func _physics_process(_delta):
	#
	# Basic Movement
	#
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	velocity.normalized()
	move_and_slide()


func _process(_delta):
	look_at(get_global_mouse_position())
	health_label.text = str(current_health)
	RunningPlayerData.player_posiiton = position


func _input(event):
	#
	# Array contains the id of the spell that should be cast when the button is pressed
	# Id is checked against the dictionary by the spell manager
	#
	if event.is_action_pressed("shoot_primary"):
		spell_manager.cast_spell(equipped_spell_ids[0])
	if event.is_action_pressed("shoot_secondary"):
		spell_manager.cast_spell(equipped_spell_ids[1])
	if event.is_action_pressed("shoot_tertiary"):
		spell_manager.cast_spell(equipped_spell_ids[2])
	if event.is_action_pressed("shoot_quaternary"):
		spell_manager.cast_spell(equipped_spell_ids[3]) 


func _on_enemy_died(enemy_name):
	add_xp(EnemyJsonData.get_xp_value(enemy_name))


func add_xp(xp_value):
	current_xp_amount += xp_value
	print(current_xp_amount)
	if(current_xp_amount > xp_for_lvlup):
		current_lvl += 1
		xp_for_lvlup = (xp_for_lvlup * 2) + xp_for_lvlup / 2
		RunningPlayerData.enemy_has_died.emit() 
