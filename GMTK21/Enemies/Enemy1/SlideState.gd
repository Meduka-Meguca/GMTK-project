extends Node

var Player = '../..'
var fsm: StateMachine
var velocity = Vector2()
var direction = Vector2()
var slide = false
export var speed = 500
export var friction = 0
export var acceleration = 0.1

func cut_residue(vector, digit):
	if vector.length() < digit:
		vector = Vector2(0,0)
	return vector
	
func enter():
	get_node(Player).animation_state_machine.travel('Slide')

func exit(next_state):
	fsm.change_to(next_state)


func process(delta):
	#get_input()
	pass
	
	
func physics_process(delta):
	get_input()
	if direction.length() > 0:
		direction = direction.normalized()
		direction.y = direction.y * 0.7
		velocity = lerp(velocity, direction * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2(0,0), friction)
	velocity = cut_residue(velocity, 5)
	
	if velocity != Vector2(0,0):
		if (slide):
			velocity = get_node(Player).move_and_slide(velocity)
			get_node(Player).animation_tree.set('parameters/Idle/blend_position',velocity)
			get_node(Player).animation_tree.set('parameters/Run/blend_position',velocity)
		elif 0 == 0:
			exit('SlideState')
	else:
		exit('IdleState')
		
		

func get_input():
	slide = false
	direction = Vector2()
	direction.x = (int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")))
	direction.y = (int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up")))
	
	if Input.is_action_pressed("Slide"):
		slide = true
