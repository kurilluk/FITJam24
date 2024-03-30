extends Node2D
@onready var fear_bar = $"../GUI/FearBar"
@onready var tramps = $"../Tramps"
@onready var level = $"../Level"
@onready var player = $"../Player"
@onready var dynamic_ambient = $"../DynamicAmbient"

# Called when the node enters the scene tree for the first time.
func _ready():
	dynamic_ambient.play()
	#pass # Replace with function body.
	
func isOutside(outside):
	if(outside):
		return
	pass

func get_stress():
	var ja = level.local_to_map(player.position)
	var tileID = level.get_cell_source_id(0,ja)
	if tileID == level.Tile.OBSTACLE:
		for T in tramps.tramps:
			T.beam.emitting=false
		get_parent().particles.emitting = true
		return 100
		
	player.particles.emitting = false		
	var total=0
	for T in tramps.tramps:
		var on = level.local_to_map(T.transform.origin)
		if((ja-on).length_squared()<3):
			#print("boom")
			T.beam.gravity.x = 100*(ja-on)[0]
			T.beam.gravity.y = 100*(ja-on)[1]
			T.beam.emitting = true
			#get_parent().particles.emitting = true
		
			#T.beam.dir
			total+=1
		else:
			#print("noboom")
			T.beam.emitting=false
			pass
			
	#fear_bar.value = 50-50*total/9
	return 100*total/9
	
func _process(delta):
	fear_bar.value = 50+get_stress()/2
