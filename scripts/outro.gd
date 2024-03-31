extends Control

@onready var dark_screen = $DarkScreen
@onready var reload = $VBoxContainer/Reload
@onready var label = $VBoxContainer/Label
@onready var statistic = $VBoxContainer/Statistic

#var game_statistic: GameStatistics

var tween
# Called when the node enters the scene tree for the first time.
func _ready():
	dark_screen.modulate.a = 0.0
	reload.modulate.a = 0.0
	#process_game_statistic()
	tween = get_tree().create_tween()
	tween.tween_property(dark_screen,"modulate:a",1.0,3.0)
	await (tween.finished)
	tween = get_tree().create_tween()
	tween.tween_property(reload,"modulate:a",1.0,0.5)
	#reload.visible = true
	#pass # Replace with function body.
#
#func process_game_statistic():
	#game_statistic = Helpers.get_game_statisitic()
	#if game_statistic.initialized:
		#statistic.text = game_statistic.get_stats()

	
func _on_reload_pressed():
	#var dark_tween = dark_screen.apear()
	#await (dark_tween.finished)
	get_tree().reload_current_scene()
	#get_tree().change_scene_to_file("res://scenes/final_game_scene.tscn")
	#pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()
	#pass # Replace with function body.
