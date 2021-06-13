extends Node

var Player = '../..'
var velocity = Vector2()
var direction = Vector2()
var slide = false
onready var trail = $Trail
export var speed = 200
export var slide_speed = 700
export var friction = 0.1
export var slide_friction = 0
export var acceleration = 0.5
export var slide_acceleration = 0.05


func cut_residue(vector, digit):
	if vector.length() < digit:
		vector = Vector2(0,0)
	return vector
	
func enter():
	get_node(Player).animation_state_machine.travel('Run')

func exit(next_state):
	get_parent().change_to(next_state)


func process(delta):
	#get_input()
	pass
	
	
func physics_process(delta):
	get_input()
	trail.emitting = false
	if direction.length() > 0:
		direction = direction.normalized()
		direction.y = direction.y * 0.5
		velocity = (lerp(velocity, direction * speed, acceleration)*(1-int(slide)) 
					+ lerp(velocity, direction * slide_speed, slide_acceleration)*(int(slide)))
	else:
		velocity = (lerp(velocity, Vector2(0,0), friction)*(1-int(slide)) + lerp(velocity, Vector2(0,0), slide_friction)*(int(slide)))
	velocity = cut_residue(velocity, 50)
	
	if velocity != Vector2(0,0):
		velocity = get_node(Player).move_and_slide(velocity)
		get_node(Player).animation_tree.set('parameters/Idle/blend_position',velocity)
		get_node(Player).animation_tree.set('parameters/Run/blend_position',velocity)
		get_node(Player).animation_tree.set('parameters/Slide/blend_position',velocity)
		trail.position = get_node(Player).position + Vector2(0,10)
		if (!slide):
			get_node(Player).animation_state_machine.travel('Run')
		elif 0 == 0:
			get_node(Player).animation_state_machine.travel('Slide')
			trail.emitting = true
			
	else:
		exit('IdleState')
		
		

func get_input():
	slide = false
	direction = Vector2()
	direction.x = (int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")))
	direction.y = (int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up")))
	
	if Input.is_action_pressed("slide"):
		slide = true
