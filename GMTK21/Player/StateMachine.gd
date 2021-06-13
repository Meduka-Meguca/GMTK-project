extends Node

const DEBUG = true

var state: Object
var history = []

func ready():
	state = get_child(0)
	_enter_state()
	
func change_to(new_state):
	if !get_parent().is_dead:
		history.append(state.name)
		state = get_node(new_state)
		_enter_state()

func back():
	if history.size() > 0:
		state = get_node(history.pop_back())
		_enter_state()

func _enter_state():
	if DEBUG:
		print(state.name)
	state.enter()

func process(delta):
	if state.has_method("process"):
		state.process(delta)

func physics_process(delta):
	if state.has_method("physics_process"):
		state.physics_process(delta)
