class_name Player extends CharacterBody2D

const SPEED = 100.0
const ROLL_SPEED = 125.0

@export var stats: Stats

var input_vector: = Vector2.ZERO
var last_input_vector: = Vector2.DOWN

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var blink_animation_player: AnimationPlayer = $BlinkAnimationPlayer
@onready var hurt_audio_stream_player: AudioStreamPlayer = $HurtAudioStreamPlayer

func _ready() -> void:
	hurtbox.hurt.connect(take_hit.call_deferred)
	stats.no_health.connect(die)

func _physics_process(delta: float) -> void:
	var state = playback.get_current_node()
	match state:
		"MoveState": move_state(delta)
		"AttackState": pass
		"RollState": roll_state(delta)

func die() -> void:
	hide()
	remove_from_group("player")
	process_mode = Node.PROCESS_MODE_DISABLED

func take_hit(other_hitbox: Hitbox) -> void:
	hurt_audio_stream_player.play()
	stats.health -= other_hitbox.damage
	blink_animation_player.play("blink")

func move_state(delta: float) -> void:
	input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
			
	if input_vector != Vector2.ZERO:
		last_input_vector = input_vector
		var direction_vector: = Vector2(input_vector.x, -input_vector.y)
		update_blend_positions(direction_vector)
	
	if Input.is_action_just_pressed("attack"):
		playback.travel("AttackState")
	
	if Input.is_action_just_pressed("roll"):
		playback.travel("RollState")
	
	velocity = input_vector * SPEED
	move_and_slide()

func roll_state(delta: float) -> void:
	velocity = last_input_vector.normalized() * ROLL_SPEED
	move_and_slide()

func update_blend_positions(direction_vector: Vector2) -> void:
	animation_tree.set("parameters/StateMachine/MoveState/RunState/blend_position", direction_vector)
	animation_tree.set("parameters/StateMachine/MoveState/StandState/blend_position", direction_vector)
	animation_tree.set("parameters/StateMachine/AttackState/blend_position", direction_vector)
	animation_tree.set("parameters/StateMachine/RollState/blend_position", direction_vector)
