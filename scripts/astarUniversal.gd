extends TileMap

enum Tile { OBSTACLE, WALL }

const CELL_SIZE = Vector2i(64, 64)
const BASE_LINE_WIDTH = 3.0
const DRAW_COLOR = Color.WHITE * Color(1, 1, 1, 0.5)

# The object for pathfinding on 2D grids.
var _astar = AStarGrid2D.new()
var _astarTrumps = AStarGrid2D.new()

var _start_point = Vector2i()
var _end_point = Vector2i()
var _path = PackedVector2Array()

@export var WIDTH:int = 64
@export var  HEIGHT:int = 16
func isInBounds(point_map):
	if(point_map.x < 0 or point_map.x >= WIDTH or point_map.y < 0 or point_map.y >= HEIGHT):
		return false
	return true
func _ready():
	# Region should match the size of the playable area plus one (in tiles).
	# In this demo, the playable area is 17×9 tiles, so the rect size is 18×10.
	_astar.region = Rect2i(0, 0, WIDTH+1, HEIGHT+1)
	_astar.cell_size = CELL_SIZE
	_astar.offset = CELL_SIZE * 0.5
	_astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	_astar.update()
	
	_astarTrumps.region = Rect2i(0, 0, WIDTH+1, HEIGHT+1)
	_astarTrumps.cell_size = CELL_SIZE
	_astarTrumps.offset = CELL_SIZE * 0.5
	_astarTrumps.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_astarTrumps.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_astarTrumps.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	_astarTrumps.update()

	for i in range(_astar.region.position.x, _astar.region.end.x):
		for j in range(_astar.region.position.y, _astar.region.end.y):
			var pos = Vector2i(i, j)
			var tileID = get_cell_source_id(0,pos)
			if tileID == Tile.OBSTACLE:
				_astarTrumps.set_point_solid(pos)
			elif tileID == Tile.WALL:
				_astarTrumps.set_point_solid(pos)
				_astar.set_point_solid(pos)


#func _draw():
	#if _path.is_empty():
		#return
#
	#var last_point = _path[0]
	#for index in range(1, len(_path)):
		#var current_point = _path[index]
		#draw_line(last_point, current_point, DRAW_COLOR, BASE_LINE_WIDTH, true)
		#draw_circle(current_point, BASE_LINE_WIDTH * 2.0, DRAW_COLOR)
		#last_point = current_point


func round_local_position(local_position):
	return map_to_local(local_to_map(local_position))


func is_point_walkable(local_position):
	var map_position = local_to_map(local_position)
	if _astar.is_in_boundsv(map_position):
		return not _astar.is_point_solid(map_position)
	return false


func clear_path():
	if not _path.is_empty():
		_path.clear()
		#erase_cell(0, _start_point)
		#erase_cell(0, _end_point)
		# Queue redraw to clear the lines and circles.
		queue_redraw()


func find_path(local_start_point, local_end_point):
	clear_path()

	_start_point = local_to_map(local_start_point)
	_end_point = local_to_map(local_end_point)
	_path = _astar.get_point_path(_start_point, _end_point)

	#if not _path.is_empty():
		#set_cell(0, _start_point, 0, Vector2i(Tile.START_POINT, 0))
		#set_cell(0, _end_point, 0, Vector2i(Tile.END_POINT, 0))

	# Redraw the lines and circles from the start to the end point.
	queue_redraw()

	return _path.duplicate()
	
func find_path_tramp(local_start_point, local_end_point,secondMap=false):
	clear_path()

	_start_point = local_to_map(local_start_point)
	if(secondMap):
		_end_point = local_end_point
		
	else:
		_end_point = local_to_map(local_end_point)
	_path = _astarTrumps.get_point_path(_start_point, _end_point)

	#if not _path.is_empty():
		#set_cell(0, _start_point, 0, Vector2i(Tile.START_POINT, 0))
		#set_cell(0, _end_point, 0, Vector2i(Tile.END_POINT, 0))

	# Redraw the lines and circles from the start to the end point.
	queue_redraw()

	return _path.duplicate()
