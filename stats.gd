class_name Stats extends Resource

@export var health: = 1 :
	set(value):
		health = value
		if health <= 0: no_health.emit()

@export var max_health: = 1

signal no_health()
