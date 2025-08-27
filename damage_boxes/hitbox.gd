class_name Hitbox extends Area2D

@export var damage: = 1
@export var knockback_amount: = 200
@export var knockback_direction: Vector2

var hit_targets: Array

func clear_hit_targets() -> void:
	hit_targets.clear()
