extends Control

@onready var dark_screen = $DarkScreen
#@onready var reload = $VBoxContainer/Reload
@onready var label = $VBoxContainer/Label
@onready var statistic = $VBoxContainer/Statistic

@onready var tutorial = $VBoxContainer/Tutorial
@onready var level_4 = $VBoxContainer/Level4
@onready var level_5 = $VBoxContainer/Level5

@onready var egg = $VBoxContainer/Egg

@onready var m_menu = $MMenu

#var game_statistic: GameStatistics

var tween
# Called when the node enters the scene tree for the first time.
func _ready():
	dark_screen.modulate.a = 0.0
	egg.modulate.a = 0.0
	statistic.modulate.a = 0.0
	m_menu.modulate.a = 0.0
	#level_4.modulate.a = 0.0
	#level_5.modulate.a = 0.0
	open()
	#process_game_statistic()
	#reload.visible = true
	#pass # Replace with function body.
#
#func process_game_statistic():
	#game_statistic = Helpers.get_game_statisitic()
	#if game_statistic.initialized:
		#statistic.text = game_statistic.get_stats()
func open():
	tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(dark_screen,"modulate:a",1.0,0.5)
	await (tween.finished)
	tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(statistic,"modulate:a",1.0,1.5)
	await (tween.finished)
	tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(egg,"modulate:a",1.0,1.5)
	await (tween.finished)
	tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(m_menu,"modulate:a",1.0,1.5)
	
func _on_reload_pressed():
	#var dark_tween = dark_screen.apear()
	#await (dark_tween.finished)
	get_tree().reload_current_scene()
	#get_tree().change_scene_to_file("res://scenes/final_game_scene.tscn")
	#pass # Replace with function body.


func _on_exit_pressed():
	#print("owner", get_owner())
	self.queue_free()
	#pass # Replace with function body.


#@export var nextID : int = 0
#var levels = {1:"res://scenes/level01.tscn",
 #2:"res://scenes/level02.tscn",
 #3:"res://scenes/level03.tscn",
 #4:"res://scenes/level04.tscn"}
#func _end():
	#if(nextID!=0):
		#if(nextID==1):
			#print(get_tree().change_scene_to_file(levels[1]))
		#elif(nextID==2):
			#print(get_tree().change_scene_to_file(levels[2]))
		#elif nextID==3:
			#print(get_tree().change_scene_to_file(levels[3]))



func _on_tutorial_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/level01.tscn")



func _on_level_4_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/level04.tscn")


func _on_level_5_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/level05.tscn")
