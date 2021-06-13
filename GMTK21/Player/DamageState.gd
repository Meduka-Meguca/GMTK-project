extends Node

var Player = '../..'
var direction
var amount

func enter():
	get_node(Player).animation_state_machine.travel('Damage')
	get_node(Player).animation_tree.set('parameters/Damage/blend_position',direction)
	get_node(Player).animation_tree.set('parameters/Death/blend_position',direction)
	get_node(Player).health -= amount
	if get_node(Player).health < 0:
		exit('DeathState')
		get_node(Player).is_dead = true
	else:
		$StaggerTimer.start()

func exit(next_state):
	get_parent().change_to(next_state)

func process(delta):
	pass

func physics_process(delta):
	get_node(Player).move_and_slide(direction*100)

func _on_StaggerTimer_timeout():
	exit('IdleState')
	$StaggerTimer.stop()
