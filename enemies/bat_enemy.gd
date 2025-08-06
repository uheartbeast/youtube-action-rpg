extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback

func _physics_process(delta: float) -> void:
	var state = playback.get_current_node()
	match state:
		"Idle": pass
		"Chase": pass
