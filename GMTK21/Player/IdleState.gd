extends Node

var Player = '../..'


func enter():
	get_node(Player).animation_state_machine.travel('Idle')

func exit(next_state):
	get_parent().change_to(next_state)

func process(delta):
	get_input()

func physics_process(delta):
	pass

func get_input():
	if (Input.is_action_pressed("move_right") or
		Input.is_action_pressed("move_left") or
		Input.is_action_pressed("move_up") or
		Input.is_action_pressed("move_down")):
			exit('RunState')
