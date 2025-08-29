extends Control

@export var player_stats: Stats

@onready var empty_hearts: TextureRect = $EmptyHearts
@onready var full_hearts: TextureRect = $FullHearts

func _ready() -> void:
	player_stats.health_changed.connect(set_full_hearts)
	set_empty_hearts(player_stats.max_health)
	set_full_hearts(player_stats.health)

func set_empty_hearts(value: int) -> void:
	empty_hearts.size.x = value * 15

func set_full_hearts(value: int) -> void:
	full_hearts.size.x = value * 15
