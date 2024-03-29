extends Node2D



const MASS = 10.0
const ARRIVE_DISTANCE = 10.0

@export var speed: float = 200.0
@export var steps: int = 3

#var _state = State.IDLE
var _velocity = Vector2()

@onready var _tile_map = $"../TileMap"

var _click_position = Vector2()
var _path = PackedVector2Array()
var _next_point = Vector2()
var _steps

func _ready():
	_change_state(Logic.State.IDLE)
	_steps = steps


func _process(_delta):
	if Logic._state != Logic.State.FOLLOW:
		return
	var arrived_to_next_point = _move_to(_next_point)
	if arrived_to_next_point:
		_path.remove_at(0)
		_steps -= 1
		if _steps <= 0:
			_change_state(Logic.State.IDLE)
		if _path.is_empty():
			_change_state(Logic.State.IDLE)
			return
		_next_point = _path[0]

func _unhandled_input(event):
	_click_position = get_global_mouse_position()
	if _tile_map.is_point_walkable(_click_position):
		#if event.is_action_pressed(&"teleport_to", false, true):
			#get_tree().reload_scene()
			#_change_state(State.IDLE)
			#global_position = _tile_map.round_local_position(_click_position)
		if event.is_action_pressed(&"move_to"):
			_change_state(Logic.State.FOLLOW)

func _input(event):
	if event.is_action_pressed("ui_left"):
		_move(Vector2(-64,0))
	elif event.is_action_pressed("ui_right"):
		_move(Vector2(64,0))
	elif event.is_action_pressed("ui_up"):
		_move(Vector2(0,-64))
	elif event.is_action_pressed("ui_down"):
		_move(Vector2(0,64))

func _move_to(local_position):
	var desired_velocity = (local_position - position).normalized() * speed
	var steering = desired_velocity - _velocity
	_velocity += steering / MASS
	position += _velocity * get_process_delta_time()
	rotation = _velocity.angle()
	return position.distance_to(local_position) < ARRIVE_DISTANCE

func _move(direction_vector:Vector2):
	_path = _tile_map.find_path(position, position + direction_vector )
	if _path.size() < 2:
		_change_state(Logic.State.IDLE)
		return
	_next_point = _path[1]
	Logic.set_actual_state(Logic.State.FOLLOW)

func _change_state(new_state):
	if new_state == Logic.State.IDLE:
		_tile_map.clear_path()
		_steps = steps
	elif new_state == Logic.State.FOLLOW:
		_path = _tile_map.find_path(position, _click_position)
		if _path.size() < 2:
			_change_state(Logic.State.IDLE)
			return
		# The index 0 is the starting cell.
		# We don't want the character to move back to it in this example.
		_next_point = _path[1]
	Logic.set_actual_state(new_state) 
