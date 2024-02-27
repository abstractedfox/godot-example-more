#This work is not licensed for use as source or training data for any language model, neural network,
#AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
#new or derived content from or based on the input set, or used to build a data set or training model for any software or
#tooling which facilitates the use or operation of such software.

extends CharacterBody3D
 
@export var speed = 14
@export var fall_acceleration = 75
var target_velocity = Vector3.ZERO

func _physics_process(delta):
	var inputDirection = Vector3.ZERO
	
	#process inputs
	if Input.is_action_pressed("move_lft"):
		inputDirection.x -= 1
		
	if Input.is_action_pressed("move_rgt"):
		inputDirection.x += 1
		
	if Input.is_action_pressed("move_fwd"):
		inputDirection.z -= 1
		
	if Input.is_action_pressed("move_bck"):
		inputDirection.z += 1

	if inputDirection != Vector3.ZERO:
		#Normalize the vector's speed when adding vectors in different directions (prevent it from going faster diagonally)
		inputDirection = inputDirection.normalized()

	#From the docs for Basis.looking_at():
	#Creates a Basis with a rotation such that the forward axis (-Z) points towards the target position.
	$Node3D_PlayerMesh.basis = Basis.looking_at(inputDirection)
	
	#Ground velocity (moving forward/back/left/right)
	target_velocity.x = inputDirection.x * speed
	target_velocity.z = inputDirection.z * speed
	
	#Vertical velocity (gravity)
	if not is_on_floor():
		target_velocity.y -= fall_acceleration * delta
		
	#velocity is inherited from CharacterBody3D. Is used and can be modified by move_and_slide()
	velocity = target_velocity
	
	#Guide says this (paraphrasing) 'smoothes the motion if it hits a wall'
	#Both works off of and affects the 'velocity' property 
	#of a CharacterBody3D (or types that inherit it)
	move_and_slide()
	
