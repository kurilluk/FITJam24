extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
var prev = 0.0
func _process(delta):
	prev+=delta
	if prev<0.5:
		return
	prev = 0.0
	
	# var bcgrndSize = Vector2(1152.,648.)
	# var pos = transform.origin+0.5*bcgrndSize
	# pos=Vector2(1.0*pos.x/bcgrndSize.x,1.0*pos.y/bcgrndSize.y)
	# var camsize = get_viewport().get_size()
	# pos=Vector2(pos.x*camsize.x,pos.y*camsize.y)
	
	var bcgrndSize = Vector2(1152.,648.)
	var camsize = 1. * get_viewport().get_size()
	var pos = transform.origin+0.5*bcgrndSize+0.5*(camsize-bcgrndSize)
	# pos=Vector2(1.0*pos.x/bcgrndSize.x,1.0*pos.y/bcgrndSize.y)
	# pos=Vector2(pos.x*camsize.x,pos.y*camsize.y)

	var text = get_viewport().get_texture().get_image()
	print("pos:",int(pos.x)," ",int(pos.y))
	var color = text.get_pixel(int(pos.x),int(pos.y))
	print("color:  ",color.r8," ",color.g8," ",color.b8)
	print()
	pass