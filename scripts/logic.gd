extends Node

enum State { IDLE, FOLLOW }

var _state = State.IDLE

func get_actual_state():
	return _state
	
func set_actual_state(new_state):
	_state = new_state



## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
