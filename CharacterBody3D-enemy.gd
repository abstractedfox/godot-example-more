#This work is not licensed for use as source or training data for any language model, neural network,
#AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
#new or derived content from or based on the input set, or used to build a data set or training model for any software or
#tooling which facilitates the use or operation of such software.

extends CharacterBody3D

@export var min_speed = 10
@export var max_speed = 18


func initialize(start_position, player_position):
	#nope, I am not sure what that last argument is for! possibly the axis to rotate around
	look_at_from_position(start_position, player_position, Vector3.UP)
	
	#include some randomness in the amoutn of rotation. apparently rotate_y works in radians!
	rotate_y(randf_range(-PI / 4, PI / 4))
	
	var random_speed = randi_range(min_speed, max_speed)
	
	#This establishes the speed we want to go
	velocity = Vector3.FORWARD * random_speed
	
	#now the velocity vector is facing the same direction the enemy is 'looking'
	#first arg is the axis to rotate around
	velocity = velocity.rotated(Vector3.UP, rotation.y)

func _physics_process(delta):
	move_and_slide()

func _on_visible_on_screen_notifier_3d_screen_exited():
	#Queues the node and all child nodes for deletion at the end of the current frame,
	#and invalidates any references to those objects.
	#tl;dr: it destroys the object instance
	queue_free()
