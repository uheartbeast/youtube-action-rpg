extends Node2D

@export var GRASS_EFFECT: PackedScene

@onready var area_2d: Area2D = $Area2D

func _ready() -> void:
	area_2d.area_entered.connect(_on_area_2d_area_entered)

func _on_area_2d_area_entered(other_area_2d: Area2D) -> void:
	var grass_effect_instance = GRASS_EFFECT.instantiate()
	get_tree().current_scene.add_child(grass_effect_instance)
	grass_effect_instance.global_position = global_position
	queue_free()
