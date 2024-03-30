class_name Tramp extends Node2D
enum State { IDLE, FOLLOW }

const MASS = 10.0
const ARRIVE_DISTANCE = 5.0

@export var speed: float = 100.0
#@export var steps: int = 3
@onready var init_position = position
@export var beam:CPUParticles2D = null


@export var waypoints: Array[Vector2i] = []
@export var sleepTimes: Array[float] = []
var goalIndex = 0
#@export var goal: Vector2 = Vector2.ZERO

var _state = State.IDLE
var _velocity = Vector2()

@onready var _tile_map = $"../../Level"

var _next_position = Vector2()
var _path = PackedVector2Array()
var _next_point = Vector2()
#var _steps

func _ready():
	_change_state(State.IDLE)
	#_steps = steps
	# _next_position = waypoints[goalIndex]
	# _change_state(State.FOLLOW)

var random = RandomNumberGenerator.new()

var timeRemaining = 0.
func _process(_delta):
	if(waypoints==[]):
		waypoints.append(_tile_map.local_to_map(position))
		sleepTimes.append(0)
	if _state != State.FOLLOW:
		timeRemaining -= _delta
		if timeRemaining <= 0:
			goalIndex += 1
			if goalIndex >= waypoints.size():
				goalIndex = 0
			_next_position = waypoints[goalIndex]
			timeRemaining = sleepTimes[goalIndex]
			_change_state(State.FOLLOW)
		return
	var arrived_to_next_point = _move_to(_next_point)
	if arrived_to_next_point:
		_path.remove_at(0)
		#_steps -= 1
		#if _steps <= 0:
			#_change_state(State.IDLE)
		if _path.is_empty():
			_change_state(State.IDLE)			
			# _next_position = init_position
			# _change_state(State.FOLLOW)
			return
		_next_point = _path[0]
		var randomSpread = 10
		_next_point.x+=random.randf_range(-randomSpread,randomSpread)
		_next_point.y+=random.randf_range(-randomSpread,randomSpread)



#func _unhandled_input(event):
	#_next_position = get_global_mouse_position()
	#if _tile_map.is_point_walkable(_next_position):
		##if event.is_action_pressed(&"teleport_to", false, true):
			##_change_state(State.IDLE)
			##global_position = _tile_map.round_local_position(_next_position)
		#if event.is_action_pressed(&"move_to"):
			#_change_state(State.FOLLOW)


func _move_to(local_position):
	var desired_velocity = (local_position - position).normalized() * speed
	var steering = desired_velocity - _velocity
	_velocity += steering / MASS
	position += _velocity * get_process_delta_time()
	rotation = _velocity.angle()
	return position.distance_to(local_position) < ARRIVE_DISTANCE


func _change_state(new_state):
	if new_state == State.IDLE:
		_tile_map.clear_path()
		#_steps = steps
	elif new_state == State.FOLLOW:
		_path = _tile_map.find_path_tramp(position, _next_position, true)
		if _path.size() < 2:
			_change_state(State.IDLE)
			return
		# The index 0 is the starting cell.
		# We don't want the character to move back to it in this example.
		_next_point = _path[1]
		
	_state = new_state
