#This work is not licensed for use as source or training data for any language model, neural network,
#AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
#new or derived content from or based on the input set, or used to build a data set or training model for any software or
#tooling which facilitates the use or operation of such software.

extends Node3D

#PackedScene holds a reference to a scene
#apparently it can also be used to save a node to a file!
@export var enemy: PackedScene
@export var enemiesEnabled = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_timer_timeout():
	if not enemiesEnabled:
		return
	
	#note that the 'enemy' object here is the one we declared at the top of this file
	var enemyInstance = enemy.instantiate()

	var spawnLocation = get_node("Path3D_SpawnPath/PathFollow3D_SpawnLocation")
	
	#progress_ratio is a distance along the 'spawnLocation' path where
	#0.0 is the first vertex and 1.0 is the last
	spawnLocation.progress_ratio = randf()

	var playerPosition = $CharacterBody3D_Player.position
	
	#'initialize' function we wrote under CharacterBody3D-enemy.tscn
	enemyInstance.initialize(spawnLocation.position, playerPosition)
	
	#add_child adds the node instance we just created under the node that this script is attached to
	#in this case, that node is the root node, or 'Main'!
	add_child(enemyInstance)
