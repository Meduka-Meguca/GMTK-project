extends Node2D

var rng = RandomNumberGenerator.new()

enum State{
	IDLE,
	CHASE,
	EVADE,
	DEAD
}

signal player_inside_attack_zone()

onready var detection_radius = $DetectionRadius
onready var attack_radius = $AttackRadius

var current_state = State.IDLE
var player = null

func _ready():
	rng.randomize()

func physics_process(delta):
	if get_parent().im_fucking_dead:
		current_state = State.DEAD
	match current_state:
		State.IDLE:
			pass
		State.CHASE:
			if player:
				get_parent().look_dir = lerp(get_parent().look_dir,self.global_position.direction_to(player.global_position).normalized(),0.1)
				get_parent().movement_dir = self.global_position.direction_to(player.global_position).normalized()
		State.EVADE:
			if player:
				get_parent().look_dir = lerp(get_parent().look_dir,self.global_position.direction_to(player.global_position).normalized(),0.1)
				get_parent().movement_dir = self.global_position.direction_to(player.global_position).normalized().rotated(1)	
			emit_signal('player_inside_attack_zone')
		State.DEAD:
			pass


func _on_DetectionRadius_body_entered(body):
	if body.is_in_group('Player'):
		player = body
		current_state = State.CHASE


func _on_AttackRadius_body_entered(body):
	if body.is_in_group('Player'):
		player = body
		current_state = State.EVADE
		

func _on_DetectionRadius_body_exited(body):
	if body.is_in_group('Player'):
		player = null
		current_state = State.IDLE


func _on_AttackRadius_body_exited(body):
	if body.is_in_group('Player'):
		current_state = State.CHASE
		
