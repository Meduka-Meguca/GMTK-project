extends Node

var master_ = '../..'

func enter():
	get_node(master_).animation_state_machine.travel('Death')
	get_node(master_).im_fucking_dead = true
	

func exit(next_state):
	get_parent().change_to(next_state)

func process(delta):
	pass

func physics_process(delta):
	pass
