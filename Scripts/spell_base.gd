class_name Spell

extends CharacterBody2D

#
# Base class that all spells MUST extend from holding different information that must be shared by all spells
#

enum damage_types{ UNTYPED, FIRE, ICE }
enum spell_usage_types{ UNLIMITED, LIMITED }

@export var spell_id: int
