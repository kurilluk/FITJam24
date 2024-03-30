extends Node2D
@onready var fear_bar = $"../../GUI/FearBar"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var r = RandomNumberGenerator.new()
	fear_bar.value=r.randi_range(0,100)
	pass
