extends Node2D

enum State { IDLE, FOLLOW }

const MASS = 10.0
const ARRIVE_DISTANCE = 10.0

@export var speed: float = 100.0
@export var steps: int = 3
@export var goal: Vector2 = Vector2.ZERO

var _state = State.IDLE
var _velocity = Vector2()

@onready var _tile_map = $"../Level"
@onready var init_position = position

var _click_position = Vector2()
var _path = PackedVector2Array()
var _next_point = Vector2()
#var _steps

func _ready():
	_change_state(State.IDLE)
	#_steps = steps
	_click_position = goal
	_change_state(State.FOLLOW)


func _process(_delta):
	if _state != State.FOLLOW:
		return
	var arrived_to_next_point = _move_to(_next_point)
	if arrived_to_next_point:
		_path.remove_at(0)
		#_steps -= 1
		#if _steps <= 0:
			#_change_state(State.IDLE)
		if _path.is_empty():
			_click_position = init_position
			_change_state(State.FOLLOW)
			return
		_next_point = _path[0]


#func _unhandled_input(event):
	#_click_position = get_global_mouse_position()
	#if _tile_map.is_point_walkable(_click_position):
		##if event.is_action_pressed(&"teleport_to", false, true):
			##_change_state(State.IDLE)
			##global_position = _tile_map.round_local_position(_click_position)
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
		_path = _tile_map.find_path(position, _click_position)
		if _path.size() < 2:
			_change_state(State.IDLE)
			return
		# The index 0 is the starting cell.
		# We don't want the character to move back to it in this example.
		_next_point = _path[1]
	_state = new_state
