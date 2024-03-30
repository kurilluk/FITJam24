extends AudioStreamPlayer

const DEFAULT_BUS_LAYOUT = preload("res://default_bus_layout.tres")



# Called when the node enters the scene tree for the first time.
func _ready():
	var filter : AudioEffectLowPassFilter = AudioServer.get_bus_effect(2,0)
	filter.get_property_list()
	
	const DEFAULT_BUS_LAYOUT = preload("res://default_bus_layout.tres")

	print("effect name:",filter.resource_name)
	
	#var filter_a : AudioEffectLowPassFilter = AudioServer.get_bus_effect_instance(2,0,0)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func change_delay() -> void:
	#var bus_idx = AudioServer.get_bus_index("Master")
	#for effect_idx in AudioServer.get_bus_effect_count(bus_idx):
		#var effect = AudioServer.get_bus_effect(bus_idx, effect_idx)
		#if effect is AudioEffectDelay:
			## Change stuff
			#pass
#
#
#@export var tap1_delay:float:
	#get:
		#return AudioServer.get_bus_effect(1,0).tap1_delay_ms
	#set(value):
		#AudioServer.get_bus_effect(1,0).tap1_delay_ms = value
		#
#var LowPass:int:
	#get:
		#return AudioServer.get_bus_effect(2,0).cutoff_hz
	#set(value):
		#AudioServer.get_bus_effect(2,0).cutoff_hz = value
#
#
#func nic():
	#LowPass = 3000
	#
