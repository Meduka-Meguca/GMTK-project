extends Node2D

var master_ = '../..'
export (PackedScene) var Bullet
var rng = RandomNumberGenerator.new()
var current_weapon = false

func _ready():
	rng.randomize()

func enter():
	current_weapon = true

func exit(next_state):
	current_weapon = false
	get_parent().change_to(next_state)

func process(delta):
	pass

func physics_process(delta):
	pass

		
func shoot():
	var bullet_arr = []
	for i in range(5):
		bullet_arr.append(Bullet.instance())
	for i in range(5):
		add_child(bullet_arr[i])
		bullet_arr[i].set_as_toplevel(true)
		bullet_arr[i].speed = 15
		bullet_arr[i].lifetime = 0.5
		#var direction = bullet_arr[i].global_position.direction_to(get_global_mouse_position()).normalized()
		var direction = get_node(master_).look_dir
		direction = direction.rotated(rng.randf_range(-0.2,0.2))
		bullet_arr[i].set_direction(direction,self.global_position + direction*20 + Vector2(0,-10))
	
	

func _on_Enemy1_attack():
	if $Cooldown.get_time_left()==0:
		shoot()
		$Cooldown.start()
