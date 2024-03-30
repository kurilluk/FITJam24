extends Node2D
enum Location { INSIDE, OUTSIDE, HEALING }
var location = Location.OUTSIDE

const MASS = 10.0
const ARRIVE_DISTANCE = 5.0

@export var speed: float = 200.0
# @export var steps: int = 3
@export var particles:CPUParticles2D = null
@export var TurnOnAtStart : Array[Node] = []

var _speed_multiplier = 1.
#var _state = State.IDLE
var _velocity = Vector2()

@onready var level = $"../Level"

# var _click_position = Vector2()
var _path = PackedVector2Array()
var _next_point_local = Vector2()
# var _steps

func _ready():
	_change_state(Logic.State.IDLE)
	# _steps = steps
	for a in TurnOnAtStart:
		a.visible = true


func _process(_delta):
	if !runningAway && (Logic._state != Logic.State.FOLLOW):
		if Input.is_action_pressed("ui_up"):
			_next_point_local = level.round_local_position(position) + Vector2(0,-64)
			Logic.set_actual_state(Logic.State.FOLLOW)
		elif Input.is_action_pressed("ui_down"):
			_next_point_local = level.round_local_position(position) + Vector2(0,64)
			Logic.set_actual_state(Logic.State.FOLLOW)
		elif Input.is_action_pressed("ui_left"):
			_next_point_local = level.round_local_position(position) + Vector2(-64,0)
			Logic.set_actual_state(Logic.State.FOLLOW)
		elif Input.is_action_pressed("ui_right"):
			_next_point_local = level.round_local_position(position) + Vector2(64,0)
			Logic.set_actual_state(Logic.State.FOLLOW)
		return

	if(Logic._state == Logic.State.IDLE):
		return;

	# if(Logic._state == Logic.State.IDLE && runningAway):
	# 	if level.get_cell_source_id(0,level.local_to_map(position)) == level.Tile.OBSTACLE:
	# 		_move_to_local(position-Vector2(64,0))
	# 		_change_state(Logic.State.FOLLOW)

			
	var arrived_to_next_point_local = _move_to_local(_next_point_local)
	if arrived_to_next_point_local:
		if(!_path.is_empty()):
			_path.remove_at(0)
		#_steps -= 1
		#if _steps <= 0:
			#_change_state(Logic.State.IDLE)
			#_move()
		if _path.is_empty():
			_change_state(Logic.State.IDLE)
			_move()
			return
		else:
			_next_point_local = _path[0]
		if(runningAway && stressPathLength>0):
			stress_meter.fear = max(0,stress_meter.fear-100./stressPathLength)

#func _unhandled_input(event):
	#_click_position = get_global_mouse_position()
	#if level.is_point_walkable(_click_position):
		#if event.is_action_pressed(&"move_to"):
			#_change_state(Logic.State.FOLLOW)

var _queue = []

# func _input(event):
# 	return
	# if event is InputEventKey and event.pressed and event.echo == false:
	# 	if event.is_action_pressed("ui_left") || event.keycode==KEY_A:
	# 		_add_to_move_queue(Vector2(-64,0))
	# 	elif event.is_action_pressed("ui_right")|| event.keycode==KEY_D:
	# 		_add_to_move_queue(Vector2(64,0))
	# 	elif event.is_action_pressed("ui_up")|| event.keycode==KEY_W:
	# 		_add_to_move_queue(Vector2(0,-64))
	# 	elif event.is_action_pressed("ui_down")|| event.keycode==KEY_S:
	# 		_add_to_move_queue(Vector2(0,64))

func _move_to_local(local_position):
	var desired_velocity = (local_position - position).normalized() * speed * _speed_multiplier
	var steering = desired_velocity - _velocity
	_velocity += steering / MASS
	position += _velocity * get_process_delta_time()
	rotation = _velocity.angle()
	var distRunning = ARRIVE_DISTANCE
	if(_speed_multiplier>1.5):
		distRunning = 10
	return position.distance_to(local_position) < distRunning

func _add_to_move_queue(target_location:Vector2):
	_queue.append(target_location)
	#_speed_multiplier = _queue.size()
	if(_queue.size() == 1):
		_move()
	else:
		pass
		
var stressPathLength = 0
func _move():
	if _queue.size() == 0 && runningAway:
		runningAway = false
		_speed_multiplier = 1
		stressPathLength = 0
	if _queue.size() == 0 || Logic._state!=Logic.State.IDLE:
		return
	var target_location = _queue[0]
	_queue.remove_at(0)
	if level.is_point_walkable(target_location):	
		_path = level.find_path_tramp(position, target_location )
	#else:
		#print(position + target_location)
	if _path.size() < 2:
		_change_state(Logic.State.IDLE)
		_queue = []
		return
	elif(runningAway):
		stressPathLength = _path.size()
		# _speed_multiplier=_path.size()
#
	_next_point_local = _path[1]
	Logic.set_actual_state(Logic.State.FOLLOW)

func _change_state(new_state):
	if new_state == Logic.State.IDLE:
		level.clear_path()
		# _steps = steps
	elif new_state == Logic.State.FOLLOW:
		#_path = level.find_path(position, _click_position)
		#if _path.size() < 2:
			#_change_state(Logic.State.IDLE)
			#return
			
		# _next_point_local = _path[1]
		pass
	Logic.set_actual_state(new_state) 


func _change_location(new_location):
	if(location==new_location):
		return
	if(new_location==Location.OUTSIDE):
		location = Location.OUTSIDE
	if(new_location==Location.INSIDE):
		location = Location.INSIDE
	if(new_location==Location.HEALING):
		location = Location.HEALING




var runningAway = false
const krokuZpet = 5
#const casZdrhani = 2.0
@onready var stress_meter = $"../StressMeter"

func stressOverload():
	if(runningAway):
		return
	runningAway = true
	var runningAwayTarget = level.local_to_map(position)
	runningAwayTarget.x = max(1,runningAwayTarget.x-krokuZpet)
	if level.get_cell_source_id(0,runningAwayTarget) == level.Tile.OBSTACLE:
		for j in range(10):
			for i in range(1,100):
				if level.get_cell_source_id(0,runningAwayTarget+Vector2i(0,i)) !=-1:
					runningAwayTarget.y += i
					break
				if level.get_cell_source_id(0,runningAwayTarget+Vector2i(0,-i)) != -1:
					runningAwayTarget.y -= i
					break
			if level.get_cell_source_id(0,runningAwayTarget) != -1:
				break
			runningAwayTarget.x -= 1

	_queue = []
	var point = level.round_local_position(position)
	var pointMap = level.local_to_map(point)
	while(level.get_cell_source_id(0,pointMap) == level.Tile.OBSTACLE):
		print("left")
		point.x -= 64
		_add_to_move_queue(point)
		pointMap = level.local_to_map(point)
	if(pointMap.x>runningAwayTarget.x):
		_add_to_move_queue(level.map_to_local(runningAwayTarget))
	_speed_multiplier=5
	
	
