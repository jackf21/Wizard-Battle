# Base class for anything considered an "entity" that needs to have the functions here such as taking damage

class_name Entity

extends CharacterBody2D

#Enum for determining the incoming damage type is
enum damage_types{ UNTYPED, FIRE, ICE }

enum entity_type{ PLAYER, FRIENDLY, ENEMY, NEUTRAL }

var current_health: float
var counter := 0
var timers = {}
var is_burning: bool = false
var is_ice_slowed: bool = false

@export var speed: float
@export var max_health: float
@export var this_entity_type: entity_type



func _ready():
	current_health = max_health



func damage_entity(damage_value: float, type: damage_types):
	match type:
		#
		# All damage types take away the player's health but some have special effects
		#
		damage_types.UNTYPED:
			current_health -= damage_value
		damage_types.FIRE:
			current_health -= damage_value
			if (!is_burning):
				apply_dot_effect(0.5, 5, damage_value * 0.1)
		damage_types.ICE:
			current_health -= damage_value
			if(!is_ice_slowed):
				apply_slow_effect(damage_value * 0.1, 0.8)
				
	if(current_health <= 0):
		if(this_entity_type == entity_type.ENEMY):
			enemy_entity_death(self.name)

func apply_dot_effect(duration_between_damage : float, num_repeats : int, damage : float):
	
	# Boolean to prevent multiple stacks of a dot effect being attached
	is_burning = true
	
	# Adding a new timer to count down between each tick of damage 
	var dot_timer = Timer.new()
	dot_timer.wait_time = duration_between_damage
	dot_timer.autostart = true
	
	# The functions for damaging the player and counting down to removing the timer are attached and ran when the timer ends
	dot_timer.timeout.connect(burn.bind(damage))
	dot_timer.timeout.connect(time_out_timer_damage.bind(counter))
	
	# Adds the timer to the timer array and adds it as a child of the entity
	timers[counter] = {repeat = num_repeats, timer = dot_timer, damage = damage, timer_type = "dot"}
	add_child(dot_timer)
	
	# Incrementing counter variable for array access
	counter += 1

func apply_slow_effect(duration_of_slow: float, slow_value: float):
	#
	# Works similarly to the dot effect but the timer only repeats once
	#
	is_ice_slowed = true
	speed *= slow_value
	var slow_timer = Timer.new()
	slow_timer.wait_time = duration_of_slow
	slow_timer.autostart = true
	slow_timer.timeout.connect(remove_slow.bind(slow_value))
	slow_timer.timeout.connect(time_out_timer_damage.bind(counter))
	timers[counter] = {repeat = 1, timer = slow_timer, damage = 0, timer_type = "slow"}
	add_child(slow_timer)
	counter += 1

func time_out_timer_damage(id):
	
	# Counting down to remove the timer 
	timers[id].repeat -= 1 
	if (timers[id].repeat == 0):
		
		# allowing for the player to be burned again only if the timer has finished repeating
		if (timers[id].timer_type == "dot"):
			is_burning = false
		
		# Deletes the timer from the scene and the array
		timers[id].timer.call_deferred("queue_free")
		timers.erase(id)

# Function for damaging the players health when the dot timer runs out
func burn(damage):
	current_health -= damage

# Restores the players speed back to normal and alllows them to be slowed again
func remove_slow(slow_value):
	speed *= 1/slow_value
	is_ice_slowed = false



# Function containing anything that needs to happen when an enemy dies
func enemy_entity_death(entity_name):
	#print(self.name + " has died")
	RunningPlayerData.enemy_has_died.emit(entity_name)
	queue_free()
