class_name Spell

extends CharacterBody2D

#
# Base class that all spells MUST extend from holding different information that must be shared by all spells
#

enum damage_types{ UNTYPED, FIRE, ICE }
enum spell_usage_types{ UNLIMITED, LIMITED }

@export var spell_id: int
@export var spell_damage_type: damage_types

func change_projectile_to_player() -> void:
	self.set_collision_layer_value(5, false)
	self.set_collision_mask_value(2, false)
	self.set_collision_layer_value(4, true)
	self.set_collision_mask_value(3, true)

func change_projectile_to_enemy() -> void:
	self.set_collision_layer_value(4, false)
	self.set_collision_mask_value(3, false)
	self.set_collision_layer_value(5, true)
	self.set_collision_mask_value(2, true)
