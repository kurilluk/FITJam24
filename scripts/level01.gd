extends Node2D

## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

const MENU = preload("res://scenes/menu.tscn")
@onready var gui = $GUI

func openMenu():
	var menu = MENU.instantiate()
	gui.add_child(menu)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		#get_tree().quit()
		openMenu()

