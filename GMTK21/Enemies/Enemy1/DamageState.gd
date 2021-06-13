extends Node

var master_ = '../..'
var direction
var amount

func enter():
	get_node(master_).animation_state_machine.travel('Damage')
	get_node(master_).animation_tree.set('parameters/Damage/blend_position',direction)
	get_node(master_).animation_tree.set('parameters/Death/blend_position',direction)
	get_node(master_).health -= amount
	if get_node(master_).health < 0:
		exit('DeathState')
	else:
		$StaggerTimer.start()

func exit(next_state):
	get_parent().change_to(next_state)

func process(delta):
	pass

func physics_process(delta):
	get_node(master_).move_and_slide(direction*100)

func _on_StaggerTimer_timeout():
	exit('IdleState')
	$StaggerTimer.stop()
