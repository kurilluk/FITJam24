extends Node2D
@onready var fear_bar = $"../GUI/FearBar"
#var time_bar = null
@onready var tramps = $"../Tramps"
@onready var level = $"../Level"
@onready var player = $"../Player"
@export var ups : int = 5
@onready var time_bar = $"../GUI/Control/TimeLimit"

@export var time:int = 0

var fear = 0.0

var timeRemaining
func _ready():
	timeRemaining = time
	pass

func get_stress():
	var ja = level.local_to_map(player.position)
	var tileID = level.get_cell_source_id(0,ja)
	if tileID == level.Tile.OBSTACLE:
		# player._change_location(player.Location.INSIDE)
		for T in tramps.tramps:
			T.beam.emitting=false
		#player.particles.emitting = true
		return 50./ups
		
	#player.particles.emitting = false
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
	return -500.*int(total)/(9.*ups)
	
var spu = 1./ups
var fromLast = 0.0
var textChanged = false
func _process(delta):
	timeRemaining-=delta
	if(time_bar!=null):
		var absTime = abs(timeRemaining)
		var minut = str(int(absTime/60))
		var sec = str(int(absTime)%60)
		if(sec.length()==1):
			sec="0"+sec
		sec+="."+str(int((absTime-int(absTime))*100))
		var timeStr = minut+":"+sec
		#print(timeStr)
		time_bar.text = timeStr
	if(!textChanged && timeRemaining<0):
		for ch in get_children():
			ch.label.text = "chill"

	fromLast+=delta
	if fromLast<spu:
		return
	fromLast=0.0

	fear+=get_stress()
	if fear>=100:
		fear=100
		player.stressOverload()
	if(fear<0):
		fear=0
	fear_bar.value = fear
