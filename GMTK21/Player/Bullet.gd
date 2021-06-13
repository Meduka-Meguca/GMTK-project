extends Area2D

export var speed = 100
export var damage = 20
var direction = Vector2(0,0)
var lifetime = 0.5

func _ready():
	$Death.wait_time = lifetime

func _physics_process(delta):
	var velocity = direction*speed
	
	global_position += velocity
	
func set_direction(direction,pos):
	self.direction = direction
	self.position = pos
	self.rotation = atan2(direction[1],direction[0])
	


func _on_Timer_timeout():
	queue_free()


func _on_Bullet_area_entered(area):
	if area.is_in_group('Hurtboxes'):
		area.take_damage(damage, direction)
		queue_free()
