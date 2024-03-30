extends Node
const PATHS = "res://scripts/paths.csv"
@onready var level = $"../Level"

var tramps = []
# Called when the node enters the scene tree for the first time.
func _ready():
	var pathss = []
	var timess = []
	var file = FileAccess.open(PATHS, FileAccess.READ)
	# get_csv_line ( String delim=”,” ) 
	while not file.eof_reached():
		var line = file.get_csv_line()
		var paths : Array[Vector2i]= []
		var times : Array[float]= []
		for i in range(0,line.size(),3):
			paths.append(Vector2i(int(line[i]),int(line[i+1])))
			times.append(1.0*float(line[i+2]))
		pathss.append(paths)
		timess.append(times)
	file.close()

	# gets children
	var children = get_children()
	var i = 0
	for child in children:
		if child.get_name().find("Tramp") != -1:
			tramps.append(child)
			child.waypoints = pathss[i]
			child.sleepTimes = timess[i]
			child.position = level.map_to_local(pathss[i][0])
			i+=1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
