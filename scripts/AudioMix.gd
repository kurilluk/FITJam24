extends AudioStreamPlayer

const DEFAULT_BUS_LAYOUT = preload("res://default_bus_layout.tres")



# Called when the node enters the scene tree for the first time.
func _ready():
	var filter = AudioServer.get_bus_effect(2,0)
	filter.cutoff_hz
	
	const DEFAULT_BUS_LAYOUT = preload("res://default_bus_layout.tres")

	print("effect name:",filter.resource_name)
	
	var filter_a = AudioServer.get_bus_effect_instance(2,0,0)
	filter_a.get_property_list()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
