extends Sprite

var x
var y
var angle
var master_ = '../..'

func _process(delta):
	rotation_degrees = 0
	x = get_local_mouse_position()
	angle = int(round(atan2(x[1],x[0]) * 180/3.14))
	rotation_degrees = angle
	
