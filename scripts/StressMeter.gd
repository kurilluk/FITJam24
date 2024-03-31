extends Node2D
@onready var fear_bar = $"../GUI/FearBar"
@onready var tramps = $"../Tramps"
@onready var level = $"../Level"
@onready var player = $"../Player"
@export var ups : int = 5

var fear = 0.0

func _ready():
	pass

func get_stress():
	var ja = level.local_to_map(player.position)
	var tileID = level.get_cell_source_id(0,ja)
	if tileID == level.Tile.OBSTACLE:
		player._change_location(player.Location.INSIDE)
		for T in tramps.tramps:
			T.beam.emitting=false
		player.particles.emitting = true
		return 10
		
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
			
	if(total>0):
		player._change_location(player.Location.HEALING)
	else:
		player._change_location(player.Location.OUTSIDE)
	return -100*total/9.
	
var spu = 1./ups
var fromLast = 0.0
func _process(delta):
	fromLast+=delta
	if fromLast<spu:
		return
	fromLast=0.0

	fear+=get_stress()
	if fear>100:
		fear=100
		player.stressOverload()
	if(fear<0):
		fear=0
	fear_bar.value = fear