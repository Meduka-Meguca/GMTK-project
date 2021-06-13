extends Node

var master_ = '../..'

func enter():
	get_node(master_).animation_state_machine.travel('Idle')

func exit(next_state):
	get_parent().change_to(next_state)

func process(delta):
	if get_node(master_).movement_dir != Vector2(0,0):
		exit('RunState')

func physics_process(delta):
	pass

