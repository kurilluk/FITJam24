extends Node

var tramps = []
# Called when the node enters the scene tree for the first time.
func _ready():
	# gets children
	var children = get_children()
	for child in children:
		if child.get_name().find("Tramp") != -1:
			tramps.append(child)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
