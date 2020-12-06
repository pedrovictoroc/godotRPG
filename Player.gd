extends KinematicBody2D

const MAX_SPEED = 60*1.6
const ACCELERATION = 10
const FRICTION = 400

var velocity = Vector2.ZERO

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
	
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = getDiferenceInXAxis()
	input_vector.y = getDiferenceInYAxis()
	
	input_vector = input_vector.normalized()
	
	if (input_vector != Vector2.ZERO):
		velocity += input_vector*ACCELERATION*delta
		#velocity = input_vector*MAX_SPEED
		velocity = velocity.clamped(MAX_SPEED*delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	move_and_collide(velocity)
