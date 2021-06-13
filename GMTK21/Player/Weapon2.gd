extends Node2D

var Player = '../..'
export (PackedScene) var Bullet
export var accuracy = 0.05
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
	get_input()

func physics_process(delta):
	pass
	
	
func get_input():
	if (Input.is_action_pressed('attack') and current_weapon and $Cooldown.get_time_left()==0):
		shoot()
		$Cooldown.start()
	if (Input.is_action_pressed("weapon1")):
		exit('Weapon1')
	if (Input.is_action_pressed("weapon2")):
		exit('Weapon2')
	if (Input.is_action_pressed("weapon3")):
		exit('Weapon3')
	if (Input.is_action_pressed("weapon4")):
		exit('Weapon4')
	if (Input.is_action_pressed("weapon5")):
		exit('Weapon5')

#func _unhandled_input(event: InputEvent):
#	if (event.is_action_pressed('attack') and current_weapon and $Cooldown.get_time_left()==0):
#		shoot()
#		$Cooldown.start()
		
func shoot():
	if !get_node(Player).is_dead:
		var bullet_arr = []
		for i in range(1):
			bullet_arr.append(Bullet.instance())
		for i in range(1):
			add_child(bullet_arr[i])
			bullet_arr[i].set_as_toplevel(true)
			bullet_arr[i].speed = 15
			bullet_arr[i].lifetime = 0.5
			var direction = bullet_arr[i].global_position.direction_to(get_global_mouse_position()).normalized()
			direction = direction.rotated(rng.randf_range(-accuracy,accuracy))
			bullet_arr[i].set_direction(direction,self.global_position + direction*20 + Vector2(0,-10))
