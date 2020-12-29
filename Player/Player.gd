extends KinematicBody2D

const MAX_SPEED = 80
const ACCELERATION = 20
const FRICTION = 140

var velocity = Vector2.ZERO

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

func getDiferenceInXAxis():
	if(Input.is_key_pressed(KEY_D)):
		return 1
	elif(Input.is_key_pressed(KEY_A)):
		return -1
	else:
		return Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

func getDiferenceInYAxis():
	if(Input.is_key_pressed(KEY_S)):
		return 1
	elif(Input.is_key_pressed(KEY_W)):
		return -1
	else:
		return 	Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
func _process(delta):
	match state:
		MOVE:
			move_state()
		
		ATTACK:
			attack_state()
		
		ROLL:
			pass


func move_state():
	var input_vector = Vector2.ZERO
	
	input_vector.x = getDiferenceInXAxis()
	input_vector.y = getDiferenceInYAxis()
	
	input_vector = input_vector.normalized()
	
	if (input_vector != Vector2.ZERO):
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector*MAX_SPEED, ACCELERATION)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
		
	velocity = move_and_slide(velocity)	

	if(Input.is_action_just_pressed("attack")):
		state = ATTACK

func attack_state():
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func attack_animation_finished():
	state=MOVE
