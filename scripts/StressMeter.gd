extends Node2D
@onready var fear_bar = $"../../GUI/FearBar"
@onready var tramps = $"../../Tramps"
@onready var level = $"../../Level"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var ja = level.local_to_map(get_parent().position)
	var total=0
	for T in tramps.tramps:
		var on = level.local_to_map(T.transform.origin)
		if((ja-on).length_squared()<3):
			T.beam.gravity.x = 100*(ja-on)[0]
			T.beam.gravity.y = 100*(ja-on)[1]
			T.beam.emitting=true
			
			#T.beam.dir
			total+=1
		else:
			T.beam.emitting=false
			
	fear_bar.value = total
	pass
