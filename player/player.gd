extends CharacterBody2D

const SPEED = 100.0

var input_vector: = Vector2.ZERO

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback

func _physics_process(delta: float) -> void:
	var state = playback.get_current_node()
	match state:
		"MoveState":
			input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
			
			if input_vector != Vector2.ZERO:
				var direction_vector: = Vector2(input_vector.x, -input_vector.y)
				update_blend_positions(direction_vector)
			
			if Input.is_action_just_pressed("attack"):
				playback.travel("AttackState")
			
			velocity = input_vector * SPEED
			move_and_slide()
		"AttackState":
			pass

func update_blend_positions(direction_vector: Vector2) -> void:
	animation_tree.set("parameters/StateMachine/MoveState/RunState/blend_position", direction_vector)
	animation_tree.set("parameters/StateMachine/MoveState/StandState/blend_position", direction_vector)
	animation_tree.set("parameters/StateMachine/AttackState/blend_position", direction_vector)
