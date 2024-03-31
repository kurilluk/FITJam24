extends CanvasLayer

## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
#@onready var menu = $Menu
const MENU = preload("res://scenes/menu.tscn")
var is_open = false

func openMenu():
	if !is_open:
		#menu.open()
		var menu = MENU.instantiate()
		add_child(menu)
		#is_open = true
		
	#else:
		

func _input(event):
	if event.is_action_pressed("menu"):
		#get_tree().quit()
		openMenu()



func _on_texture_button_pressed():
	pass # Replace with function body.
