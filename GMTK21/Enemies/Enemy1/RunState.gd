extends Node

var master_ = '../..'
var velocity = Vector2()
var direction = Vector2()
export var speed = 200
export var friction = 0.1
export var acceleration = 0.5


func cut_residue(vector, digit):
	if vector.length() < digit:
		vector = Vector2(0,0)
	return vector
	
func enter():
	get_node(master_).animation_state_machine.travel('Run')

func exit(next_state):
	get_parent().change_to(next_state)


func process(delta):
	pass
		
func physics_process(delta):
	direction = get_node(master_).movement_dir
	if direction.length() > 0:
		direction = direction.normalized()
		direction.y = direction.y * 0.5
		velocity = lerp(velocity, direction * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2(0,0), friction)
	velocity = cut_residue(velocity, 50)
	
	if velocity != Vector2(0,0):
		velocity = get_node(master_).move_and_slide(velocity)
		get_node(master_).animation_tree.set('parameters/Idle/blend_position',velocity)
		get_node(master_).animation_tree.set('parameters/Run/blend_position',velocity)
		get_node(master_).animation_tree.set('parameters/Slide/blend_position',velocity)
		get_node(master_).animation_state_machine.travel('Run')
	else:
		exit('IdleState')
		
		

