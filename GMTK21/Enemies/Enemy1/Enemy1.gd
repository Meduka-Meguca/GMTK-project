extends KinematicBody2D


var animation_tree 
var animation_state_machine

var im_fucking_dead = false
var movement_dir = Vector2(0,0)
var look_dir = Vector2(0,0)

export var health = 100
signal attack()
 

func _ready():
	animation_tree = $AnimationTree
	animation_state_machine = $AnimationTree.get("parameters/playback")
	$StateMachine.ready()
	$WeaponStateMachine.ready()
	
func _process(delta):
	$StateMachine.process(delta)
	$WeaponStateMachine.process(delta)
	

func _physics_process(delta):
	$StateMachine.physics_process(delta)
	$WeaponStateMachine.physics_process(delta)
	$AI.physics_process(delta)


func _on_Hurtbox_taken_damage(amount, direction):
	$StateMachine/DamageState.amount = amount
	$StateMachine/DamageState.direction = direction
	$StateMachine.change_to('DamageState')


func _on_AI_player_inside_attack_zone():
	emit_signal('attack')
