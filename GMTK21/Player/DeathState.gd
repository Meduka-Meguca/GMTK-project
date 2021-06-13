extends Node

var Player = '../..'

func enter():
	get_node(Player).animation_state_machine.travel('Death')

func exit(next_state):
	get_parent().change_to(next_state)

func process(delta):
	pass

func physics_process(delta):
	pass
