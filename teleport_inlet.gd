extends Area3D

@export var outlet: Node3D
@export var visibleInGame = true

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = visibleInGame
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	print(body.global_position)
	
	#body.global_position = outlet.global_position
	body.global_position = outlet.global_position + (body.global_position - self.global_position)
