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
var menu_instance : Control

func remove_menu():
	if is_instance_valid(menu_instance):
		menu_instance.queue_free()
		
func add_menu():
	# only instance a new scene 2 if there is none yet
	if !is_instance_valid(menu_instance):
		menu_instance = MENU.instance()
		add_child(menu_instance)
	else:
		print ("Scene 2 was already instanced before")


func openMenu():
	if is_instance_valid(menu_instance):
		menu_instance.queue_free()
	else:
		menu_instance = MENU.instantiate()
		add_child(menu_instance)

func _input(event):
	if event.is_action_pressed("menu"):
		#get_tree().quit()
		openMenu()



func _on_texture_button_pressed():
	pass # Replace with function body.
