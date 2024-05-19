class_name Entity

extends CharacterBody2D

enum damage_types{ UNTYPED, FIRE, ICE }

@export var speed: float
@export var max_health: float
var current_health: float
var counter := 0
var timers = {}

func _ready():
	current_health = max_health

func damage_entity(damage_value: float, type: damage_types):
	match type:
		damage_types.UNTYPED:
			current_health -= damage_value
		damage_types.FIRE:
			current_health -= damage_value
			apply_dot_effect(0.5, 5, damage_value * 0.1)
		damage_types.ICE:
			current_health -= damage_value
			apply_slow_effect(damage_value * 0.1, 0.8)

func apply_dot_effect(duration_between_damage : float, repeat_time : int, damage : float):
	var dot_timer = Timer.new()
	dot_timer.wait_time = duration_between_damage
	dot_timer.autostart = true
	dot_timer.timeout.connect(burn.bind(damage))
	dot_timer.timeout.connect(time_out_timer_damage.bind(counter))
	timers[counter] = {repeat = repeat_time, timer = dot_timer, damage = damage}
	add_child(dot_timer)
	counter += 1

func apply_slow_effect(duration_of_slow: float, slow_value: float):
	speed *= slow_value
	var slow_timer = Timer.new()
	slow_timer.wait_time = duration_of_slow
	slow_timer.autostart = true
	slow_timer.timeout.connect(remove_slow.bind(slow_value))
	slow_timer.timeout.connect(time_out_timer_damage.bind(counter))
	timers[counter] = {repeat = 1, timer = slow_timer, damage = 0}
	add_child(slow_timer)
	counter += 1

func time_out_timer_damage(id):
	timers[id].repeat -= 1
	if (timers[id].repeat == 0):
		timers[id].timer.call_deferred("queue_free")
		timers.erase(id)

func burn(damage):
	current_health -= damage

func remove_slow(slow_value):
	speed *= 1/slow_value
