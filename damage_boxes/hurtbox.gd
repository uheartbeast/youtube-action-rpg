class_name Hurtbox extends Area2D

signal hurt(hitbox: Hitbox)

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area_2d: Area2D) -> void:
	if area_2d is not Hitbox: return
	var hitbox = area_2d as Hitbox
	if self in hitbox.hit_targets: return
	if hitbox.stores_hit_targets: hitbox.hit_targets.append(self)
	hurt.emit(hitbox)
