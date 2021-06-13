extends Area2D

signal taken_damage(amount, direction)

func take_damage(amount,direction):
	emit_signal('taken_damage',amount,direction)


