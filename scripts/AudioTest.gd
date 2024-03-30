extends AudioStreamPlayer

#func change_delay() -> void:
	#var bus_idx = AudioServer.get_bus_index("Master")
	#for effect_idx in AudioServer.get_bus_effect_count(bus_idx):
		#var effect = AudioServer.get_bus_effect(bus_idx, effect_idx)
		#if effect is AudioEffectDelay:
			## Change stuff
			#pass


@export var tap1_delay:float:
	get:
		return AudioServer.get_bus_effect(1,0).tap1_delay_ms
	set(value):
		AudioServer.get_bus_effect(1,0).tap1_delay_ms = value
		
@export var LowPass:int:
	get:
		return AudioServer.get_bus_effect(2,0).cutoff_hz
	set(value):
		AudioServer.get_bus_effect(2,0).cutoff_hz = value

@export var volume_dis : float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	LowPass = 20000
	AudioServer.set_bus_volume_db(1,volume_dis)
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	LowPass -= 1000 * delta
	print("filter",LowPass)
	AudioServer.get_bus_volume_db(1)
	volume_dis -= 0.01
	print("volume",volume_dis)
	AudioServer.set_bus_volume_db(1,volume_dis)

	#pass
