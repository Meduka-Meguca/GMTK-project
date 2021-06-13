extends KinematicBody2D


var animation_tree 
var animation_state_machine

export var health = 100
 

func _ready():
	animation_tree = $AnimationTree
	animation_state_machine = $AnimationTree.get("parameters/playback")
	$StateMachine.ready()
	$WeaponStateMachine.ready()
	
func _process(delta):
	$StateMachine.process(delta)
	$WeaponStateMachine.process(delta)
	$Camera.offset = get_local_mouse_position()/3
	

func _physics_process(delta):
	$StateMachine.physics_process(delta)
	$WeaponStateMachine.physics_process(delta)


func _on_Hurtbox_taken_damage(amount, direction):
	$StateMachine/DamageState.amount = amount
	$StateMachine/DamageState.direction = direction
	$StateMachine.change_to('DamageState')
