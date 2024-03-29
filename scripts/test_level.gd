extends Control

func _unhandled_input(event):
	if event.is_action_pressed(&"teleport_to", false, true):
		get_tree().reload_current_scene()

## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
