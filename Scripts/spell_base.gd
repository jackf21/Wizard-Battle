class_name Spell

extends Area2D

enum damage_types{ UNTYPED, FIRE, ICE }
enum spell_usage_types{ UNLIMITED, LIMITED }

var is_used_up := false

@export var number_of_uses: int
@export var spell_usage_type: spell_usage_types

func _process(_delta):
	if number_of_uses == 0:
		is_used_up = true
